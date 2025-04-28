# Use the official .NET SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything
COPY . .

# Find your project folder and restore
WORKDIR /src/YourProjectFolderName
RUN dotnet restore

# Build and publish
RUN dotnet publish -c Release -o /app/publish

# Use a smaller runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Interior_API.dll"]
