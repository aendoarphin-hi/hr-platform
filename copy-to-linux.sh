#!/bin/bash
echo "Copying dist to network drive..."
rsync -rv --delete --exclude='.htaccess' --exclude='._*' --exclude='.DS_Store' ./dist/ "/Users/admin/nfs_wwwroot/ttprod/v3/hrcomms"
echo "Removing macOS dot-underscore files..."
find "/Users/admin/nfs_wwwroot/ttprod/v3/hrcomms" -type f -name '._*' -delete