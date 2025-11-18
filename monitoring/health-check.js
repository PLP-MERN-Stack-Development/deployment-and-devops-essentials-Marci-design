#!/usr/bin/env node

// Health Check Script for Monitoring
// This script can be used to monitor application health

const http = require('http');
const https = require('https');

const config = {
  backendUrl: process.env.BACKEND_URL || 'http://localhost:5000',
  frontendUrl: process.env.FRONTEND_URL || 'http://localhost:5173',
  timeout: 10000,
};

function checkHealth(url) {
  return new Promise((resolve, reject) => {
    const protocol = url.startsWith('https') ? https : http;

    const req = protocol.get(url, { timeout: config.timeout }, (res) => {
      if (res.statusCode >= 200 && res.statusCode < 300) {
        resolve({
          url,
          status: 'healthy',
          statusCode: res.statusCode,
          responseTime: Date.now() - startTime
        });
      } else {
        reject({
          url,
          status: 'unhealthy',
          statusCode: res.statusCode,
          error: `HTTP ${res.statusCode}`
        });
      }
    });

    const startTime = Date.now();

    req.on('error', (err) => {
      reject({
        url,
        status: 'unhealthy',
        error: err.message
      });
    });

    req.on('timeout', () => {
      req.destroy();
      reject({
        url,
        status: 'unhealthy',
        error: 'Request timeout'
      });
    });
  });
}

async function runHealthChecks() {
  console.log('🔍 Running health checks...');

  const checks = [
    { name: 'Backend Health', url: `${config.backendUrl}/health` },
    { name: 'Backend Root', url: config.backendUrl },
    { name: 'Frontend', url: config.frontendUrl }
  ];

  const results = [];

  for (const check of checks) {
    try {
      const result = await checkHealth(check.url);
      results.push({
        ...result,
        name: check.name
      });
      console.log(`✅ ${check.name}: ${result.status} (${result.responseTime}ms)`);
    } catch (error) {
      results.push({
        ...error,
        name: check.name
      });
      console.log(`❌ ${check.name}: ${error.status} - ${error.error}`);
    }
  }

  // Overall status
  const healthyCount = results.filter(r => r.status === 'healthy').length;
  const totalCount = results.length;

  console.log(`\n📊 Overall Health: ${healthyCount}/${totalCount} services healthy`);

  // Exit with error code if any service is unhealthy
  if (healthyCount < totalCount) {
    process.exit(1);
  }
}

// Run health checks if this script is executed directly
if (require.main === module) {
  runHealthChecks().catch(console.error);
}

module.exports = { checkHealth, runHealthChecks };