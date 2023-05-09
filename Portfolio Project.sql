Select * from NashvilleHousing


---Standardize Date format
 Select  SaleDateConverted ,convert(Date, SaleDate) from NashvilleHousing
 
 
 Update NashvilleHousing
 Set SaleDate = convert(Date,SaleDate)
 
 
 Alter table NashvilleHousing
 Add SaleDateConverted Date;
 
 
 Update NashvilleHousing 
 Set SaleDateConverted = Convert(Date,SaleDate)
 
 ------Populate Property Address Data
 
 Select * from NashvilleHousing 
 Order by ParcelId
 
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From   NashvilleHousing a
JOIN NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

 
 Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


-- Breaking out Address into Individual Columns (Address, City, State)
   

   Select PropertyAddress  from NashvilleHousing

--Where PropertyAddress is null
--order by ParcelID
  Select
  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
   from NashvilleHousing
 
 
 
 Select * from NashvilleHousing
 
 
 Alter table NashvilleHousing
 Add PropertySplitAddress Nvarchar(255);
 
 Alter table NashvilleHousing
 Drop  column PropertySpitAddress
 
 update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

  Alter table NashvilleHousing
 Add PropertySplitCity Nvarchar(255);
 
 update NashvilleHousing
 set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))
 
 
 Select OwnerAddress from NashvilleHousing
 
 Select Parsename(REPLACE(OwnerAddress,',', '.'),3),
  Parsename(REPLACE(OwnerAddress,',', '.'),2),
   Parsename(REPLACE(OwnerAddress,',', '.'),1)
   from NashvilleHousing
   
  ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



-- Change Y and N to Yes and No in "Sold as Vacant" field

  Select Distinct (Soldasvacant),COUNT(Soldasvacant)
  from NashvilleHousing
  Group by SoldAsVacant
  order by 2
   
   
  Select Soldasvacant , 
  CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
     from NashvilleHousing
     
  Update NashvilleHousing
  Set SoldAsVacant =  CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END 
     
     














 
   
   
   
   
   
   
 
 
 
 
 
 
 
 
 
 