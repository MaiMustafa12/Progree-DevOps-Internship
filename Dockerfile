FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["ProgreeWebApp.csproj", "./"]
RUN dotnet restore "ProgreeWebApp.csproj"
COPY . .
RUN dotnet publish "ProgreeWebApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
COPY --from=build /app/publish .
USER app
ENTRYPOINT ["dotnet", "ProgreeWebApp.dll"]
