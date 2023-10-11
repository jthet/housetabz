echo "Installing dependencies..."
bundle install 
echo "Creating DB (may already exist)..."
rails db:create
echo "Migrating DB..."
rails db:migrate

echo "Starting Server"
bin/dev
