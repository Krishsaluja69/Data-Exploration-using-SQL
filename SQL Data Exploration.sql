
--Looking at Total cases vs Total Deaths

Select Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from Project1..coviddeaths
where Location like '%india%'
order by 1,2


--Looking at Total cases vs Population

Select Location, date, total_cases, new_cases, population, (total_cases/population)*100 as PercentPopulationInfected
from Project1..coviddeaths
where Location like '%india%' 
order by 1,2


--Looking at Countries with highest Infection rate compared to population

 Select Location,max(total_cases) as HighestInfectionCount, population, max((total_cases/population))*100 as PercentPopulationInfected
from Project1..coviddeaths
group by population,location
order by PercentPopulationInfected desc


--Looking at Countries with Highest Death count per population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Project1..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc


-- Looking at contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Project1..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


--Global Numbers

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercentage
from Project1..CovidDeaths
where continent is not null
order by 1,2


-- Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as Sum_of_vaccination
From Project1..CovidDeaths dea
Join Project1..Covidvaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
