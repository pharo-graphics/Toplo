Class {
	#name : #ToTheme,
	#superclass : #Object,
	#instVars : [
		'icons',
		'tokenProperties'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToTheme class >> canBeDefault [

	^ false
]

{ #category : #accessing }
ToTheme class >> defaultCheckboxBlankImage [

	| bar im |
	bar := BlElement new id: #'indeterminate-bar'.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 3.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	bar margin: (BlInsets left: 2 right: 2).
	bar geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	im := BlElement new id: #'icon-image'.
	im layout: BlFrameLayout new.
	im size: self defaultCheckboxHeight asPoint.
	im addChild: bar.
	im addAllStamps: #( #'inner-image' #unchecked ).
	^ im
]

{ #category : #accessing }
ToTheme class >> defaultCheckboxHeight [

	^ 14
]

{ #category : #accessing }
ToTheme class >> defaultColorPrimary [

	^ Color fromHexString: '#1677ff'
]

{ #category : #accessing }
ToTheme class >> defaultEmptySimpleForm [

	^ Form
		  extent: 64 @ 41
		  depth: 32
		  fromArray:
			  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1339611352 2077940442
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     2077940442 1306254299 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1843059418 3185170905
			     2044320217 2161760729 2161760729 2161760729 2161760729
			     2161760729 2161760729 2161760729 2161760729 2161760729
			     2161760729 2161760729 2161760729 2161760729 2161760729
			     2161760729 2161760729 2161760729 2161760729 2161760729
			     2161760729 2027543001 3185170905 1809439193 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2212158170
			     1624955610 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1675155672
			     2161760729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 1977277146 2312689880 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2379864537 1910102489 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1457051864
			     2832849369 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 2883115224 1406851802 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 953932763 3336100056 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3386497497
			     903469529 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 450418904 3839482329 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 3889748184 400482014 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4258912729
			     33554431 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 83886079 4208515288 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 3738819033 551016407 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 567859416
			     3722041817 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3235436760
			     1054530266 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 1071373275 3218659544 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 2732186073 1557715160 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     1574558169 2715408857 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 2228803800 2061097433 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2077940442
			     2212026584 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1691998681
			     2597968345 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2597968345 1691998681
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1289411290 3436763352
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     1691998681 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1691998681
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     2144983513 2144983513 2144983513 2144983513 2144983513
			     3436763352 1305991127 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121
			     4292993505 4293519849 4293519849 4293519849 4293519849
			     4293519849 4293519849 4293519849 4293519849 4293519849
			     4293519849 4159236328 3386826462 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 33554431 3420315101 4159236328 4293519849 4293519849
			     4293519849 4293519849 4293519849 4293519849 4293519849
			     4293519849 4293519849 4293519849 4292993505 3235436760
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121 4293585642
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4125813482 2447302366 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 2514213851 4293651435 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4293519849 3235436760
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121 4293585642
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294177779 3571178459 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 3621510107 4294177779 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4293519849 3235436760
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121 4293585642
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294506744 4225358297 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 4258912729 4294572537 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4293519849 3235436760
			     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121 4293585642
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 3957449185 1306254299 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 0 0 1440472027 3923894753 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 3235436760 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 3839942880
			     2883509982 3185368284 3185368284 3185368284 3185368284
			     3185368284 3185368284 3185368284 3185368284 3185368284
			     3185368284 3185368284 3185368284 3185368284 3185368284
			     2900287198 3823165664 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 3235436760 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294572537
			     4293980400 4293914607 4293914607 4293914607 4293914607
			     4293914607 4293914607 4293914607 4293914607 4293914607
			     4293914607 4293914607 4293914607 4293914607 4293914607
			     4293980400 4294572537 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 3235436760 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 3235436760 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3201948121
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 3235436760 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2144983513
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 2161760729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2144983513
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 2161760729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2144983513
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 2161760729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2144983513
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 2161760729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2144983513
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 2161760729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2144983513
			     4293585642 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293519849 2161760729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 821359860
			     2146825717 3756385765 4293585642 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4293519849 3756385765 2146825717
			     821359860 0 0 0 0 0 0 0 0 0 553121783 2415195380 4025808116
			     4294309365 4294309365 4293388263 4293585642 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4293519849 4293388263
			     4294309365 4294309365 4025808116 2415195380 553121783
			     0 0 0 0 553121783 3220501748 4294309365 4294309365 4294309365
			     4294309365 4294309365 4293388263 4293585642 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4293519849 4293388263
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     3220501748 553121783 0 1089992695 4025808116 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4293519849 4293519849 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4293454056 4293519849 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4025808116
			     821359860 3757438453 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4293717228
			     4293322470 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4293256677 4293783021 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 3757438453
			     3774215669 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4292927712
			     4294177779 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294638330 4294638330
			     4294638330 4294638330 4294638330 4294111986 4292927712
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 3774215669 1089992695
			     4042585332 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294243572 4292861919
			     4293256677 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293585642 4293585642 4293585642 4293585642
			     4293585642 4293388263 4292796126 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4042585332 821359860 0 553121783 3237278964
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294243572 4293585642 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293388263
			     4293388263 4293388263 4293388263 4293388263 4293585642
			     4294243572 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 3237278964 553121783
			     0 0 0 0 553121783 2431972596 4042585332 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4042585332 2431972596 553121783 0 0 0 0 0 0 0 0 0 821359860
			     2163602933 3237278964 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 3237278964 2163602933
			     821359860 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 821359860 1626666228
			     2163602933 3237278964 3505780213 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 3505780213 3237278964 2163602933
			     1626666228 821359860 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 0 0 0 0 553121783 1089992695 1358296565 2163602933
			     2163602933 2431972596 3237278964 3237278964 3237278964
			     3237278964 4042585332 4294309365 4294309365 4294309365
			     4294309365 4294309365 4294309365 4294309365 4294309365
			     4294309365 4294309365 4042585332 3237278964 3237278964
			     3237278964 3237278964 2431972596 2163602933 2163602933
			     1358296565 1089992695 553121783 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			     0 )
		  offset: 0 @ 0
]

{ #category : #accessing }
ToTheme class >> defaultTokenProperties [
	" skin managing need a list of unique stamps . "

	^ {
		  (ToTokenProperty
			   name: #'sh-style-table'
			   value: SHRBTextStyler defaultStyleTable).
		  (ToTokenProperty
			   name: #'default-empty-form'
			   value: self defaultEmptySimpleForm).
		  (ToTokenProperty name: #'background-color' value: Color white).
		  (ToTokenProperty name: #'submenu-arrow-right' value: [
			   (ToMaterialDesignIconProvider iconNamed:
					    'outlined_keyboardarrowright')
				   size: 18 asPoint;
				   innerImageColor: Color gray;
				   yourself ]).
		  (ToTokenProperty name: #'submenu-arrow-down' value: [
			   (ToMaterialDesignIconProvider iconNamed:
					    'outlined_keyboardarrowdown')
				   size: 18 asPoint;
				   innerImageColor: Color gray;
				   yourself ]).
		  (ToTokenProperty name: #'submenu-arrow-up' value: [
			   (ToMaterialDesignIconProvider iconNamed:
					    'outlined_keyboardarrowup')
				   size: 18 asPoint;
				   innerImageColor: Color gray;
				   yourself ]).
		  (ToTokenProperty name: #'border-radius' value: 4).
		  (ToTokenProperty name: #'border-radius-LG' value: 8).
		  (ToTokenProperty name: #'border-radius-SM' value: 4).

		  (ToTokenProperty
			   name: #'animation-window-opening'
			   value: [ :win |
				   win opacity: 0.1.
				   win addAnimation:
					   ((BlOpacityAnimation new opacity: 1.9) duration:
						    500 milliSeconds) ]).

		  (ToTokenProperty
			   name: #'effect-window'
			   value: (BlGaussianShadowEffect
					    color: (Color veryLightGray alpha: 0.5)
					    width: 20
					    offset: 0 @ 4)).

		  (ToTokenProperty
			   name: #'effect-window-menu'
			   value: (BlGaussianShadowEffect
					    color: Color lightGray
					    width: 15
					    offset: 0 asPoint)).

		  (ToTokenProperty
			   name: #'color-bg-container'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-bg-container-disabled'
			   value: (Color black alpha: 0.04)).
		  (ToTokenProperty name: #'color-bg-tooltip' value: Color white).
		  (ToTokenProperty
			   name: #'color-bg-text-active'
			   value: (Color black alpha: 0.15)).
		  (ToTokenProperty
			   name: #'color-bg-text-hover'
			   value: (Color black alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-border'
			   value: (Color fromHexString: '#d9d9d9')).
		  (ToTokenProperty
			   name: #'color-border-checkable'
			   value: Color transparent).
		  (ToTokenProperty
			   name: #'color-border-disabled'
			   value: (Color black alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-border-indeterminate'
			   value: self defaultColorPrimary lighter).
		  (ToTokenProperty
			   name: #'color-error-bg'
			   value: (Color fromHexString: '#fff2f0')).
		  (ToTokenProperty
			   name: #'color-error-hover'
			   value: (Color fromHexString: '#ff7875')).
		  (ToTokenProperty
			   name: #'color-error-pressed'
			   value: (Color fromHexString: '#e75c5d')).
		  (ToTokenProperty
			   name: #'color-error'
			   value: (Color fromHexString: '#ff4d4f')).
		  (ToTokenProperty
			   name: #'color-image-disabled'
			   value: (Color black alpha: 1.0)).
		  (ToTokenProperty
			   name: #'color-image-light-solid'
			   value: (Color fromHexString: '#ffffff')).

		  (ToTokenProperty
			   name: #'color-link'
			   value: (Color fromHexString: '#1677ff')).
		  (ToTokenProperty
			   name: #'color-link-active'
			   value: (Color fromHexString: '#0958d9')).
		  (ToTokenProperty
			   name: #'color-link-hover'
			   value: (Color fromHexString: '#69b1ff')).

		  (ToTokenProperty
			   name: #'color-primary'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'color-primary-pressed'
			   value: self defaultColorPrimary darker darker).
		  (ToTokenProperty
			   name: #'color-primary-checked'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'text-color-primary-checked'
			   value: Color white).
		  (ToTokenProperty
			   name: #'color-primary-unchecked'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-primary-indeterminate'
			   value: (self defaultColorPrimary alpha: 0.5)).
		  (ToTokenProperty
			   name: #'color-primary-hover'
			   value: self defaultColorPrimary lighter lighter).

		  (ToTokenProperty
			   name: #'color-success'
			   value: (Color fromHexString: '#52c41a')).
		  (ToTokenProperty
			   name: #'color-warning'
			   value: (Color fromHexString: '#faad14')).

		  (ToTokenProperty name: #'color-text' value: Color black).
		  (ToTokenProperty
			   name: #'color-text-description'
			   value: (Color black alpha: 0.45)).
		  (ToTokenProperty
			   name: #'color-text-disabled'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'color-text-heading'
			   value: (Color black alpha: 0.88)).
		  (ToTokenProperty
			   name: #'color-text-light-solid'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-text-secondary'
			   value: (Color black alpha: 0.45)).
		  (ToTokenProperty
			   name: #'label-selected-focused'
			   value: Color white).
		  (ToTokenProperty
			   name: #'label-selected-unfocused'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'text-foreground-in-tooltip'
			   value: (Color fromHexString: '#313339')).

		  (ToTokenProperty name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToTokenProperty name: #'font-family-code' value: 'Courier').
		  (ToTokenProperty name: #'font-size' value: 14).
		  (ToTokenProperty name: #'font-size-in-tooltip' value: 12).
		  (ToTokenProperty name: #'font-size-H1' value: 38).
		  (ToTokenProperty name: #'font-size-H2' value: 30).
		  (ToTokenProperty name: #'font-size-H3' value: 24).
		  (ToTokenProperty name: #'font-size-H4' value: 20).
		  (ToTokenProperty name: #'font-size-H5' value: 16).
		  (ToTokenProperty name: #'font-weight-strong' value: 600).

		  (ToTokenProperty name: #'line-height' value: 1).
		  (ToTokenProperty name: #'line-height-H1' value: 1.2).
		  (ToTokenProperty name: #'line-height-H2' value: 1.3).
		  (ToTokenProperty name: #'line-height-H3' value: 1.3).
		  (ToTokenProperty name: #'line-height-H4' value: 1.4).
		  (ToTokenProperty name: #'line-height-H5' value: 1.5).

		  (ToTokenProperty name: #'line-type' value: #solid).
		  (ToTokenProperty name: #'line-width' value: 1).
		  (ToTokenProperty name: #'focus-border-width' value: 2).
		  (ToTokenProperty
			   name: #'focus-border-paint'
			   value: self defaultColorPrimary).
		  (ToTokenProperty name: #'border-width' value: 1).
		  (ToTokenProperty name: #'border-paint' value: Color lightGray).

		  "Size, margin and padding"
		  (ToTokenProperty name: #'control-height' value: 32).
		  (ToTokenProperty name: #'control-height-LG' value: 40).
		  (ToTokenProperty name: #'control-height-SM' value: 24).

		  (ToTokenProperty name: #'margin-XS' value: 8).

		  (ToTokenProperty name: #'padding-content-H' value: 12).
		  (ToTokenProperty name: #'padding-content-HS' value: 4).
		  (ToTokenProperty name: #'padding-content-HXS' value: 2).
		  (ToTokenProperty name: #'padding-content-V' value: 6).
		  (ToTokenProperty name: #'padding-content-VS' value: 4).
		  (ToTokenProperty name: #'padding-content-VXS' value: 2).
		  (ToTokenProperty name: #'padding-XS' value: 8).
		  (ToTokenProperty name: #'padding-XXS' value: 3).

		  (ToTokenProperty name: #'button-interspace' value: 4).
		  (ToTokenProperty name: #'list-padding-H' value: 6).
		  (ToTokenProperty name: #'list-padding-V' value: 6).
		  (ToTokenProperty name: #'list-node-padding-H' value: 3).
		  (ToTokenProperty name: #'list-node-padding-V' value: 1).
		  (ToTokenProperty name: #'bar-node-padding-H' value: 3).
		  (ToTokenProperty name: #'bar-node-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-node-padding-H' value: 1).
		  (ToTokenProperty name: #'menu-node-padding-V' value: 1).
		  (ToTokenProperty name: #'menu-button-padding-H' value: 3).
		  (ToTokenProperty name: #'menu-button-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-window-padding-H' value: 6).
		  (ToTokenProperty name: #'menu-window-padding-V' value: 6).
		  (ToTokenProperty name: #'segmented-node-padding-H' value: 0).
		  (ToTokenProperty name: #'segmented-node-padding-V' value: 0).
		  (ToTokenProperty name: #'segmented-border-radius' value: 12).
		  (ToTokenProperty
			   name: #'segmented-background'
			   value: (Color veryLightGray alpha: 0.06)).


		  (ToTokenProperty
			   name: #'text-editor-background-disabled'
			   value: (Color black alpha: 0.1)).
		  (ToTokenProperty name: #'text-editor-padding-H' value: 3).
		  (ToTokenProperty name: #'text-editor-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-item-start-alignment' value: 22).
		  (ToTokenProperty name: #'inline-item-gap' value: 7).
		  (ToTokenProperty
			   name: #'checkbox-image-builder'
			   value: [ self defaultCheckboxBlankImage ]).
		  (ToTokenProperty
			   name: #'switch-checked-background'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'switch-unchecked-background'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'switch-disabled-background'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'switch-handle-disabled-background'
			   value: Color veryLightGray).
		  (ToTokenProperty
			   name: #'switch-handle-enabled-background'
			   value: Color white).
		  (ToTokenProperty
			   name: #'switch-icon-size'
			   value: 24 @ self defaultCheckboxHeight).

		  (ToTokenProperty
			   name: #'color-primary-selection-focused'
			   value: (self defaultColorPrimary alpha: 0.6)).
		  (ToTokenProperty
			   name: #'color-primary-selection-over-focused'
			   value: (self defaultColorPrimary alpha: 0.1)).
		  (ToTokenProperty
			   name: #'color-primary-selection-unfocused'
			   value: (self defaultColorPrimary alpha: 0.1)).
		  (ToTokenProperty
			   name: #'color-primary-selection-over-unfocused'
			   value: (self defaultColorPrimary alpha: 0.05)).
		  (ToTokenProperty
			   name: #'color-primary-selection-disabled'
			   value: (Color gray alpha: 0.3)).
		  (ToTokenProperty
			   name: #'color-secondary-selection'
			   value: (Color veryLightGray alpha: 0.1)).

		  (ToTokenProperty name: #'border-width-primary-selection' value: 1).
		  (ToTokenProperty
			   name: #'border-color-danger-selection'
			   value: Color red).
		  (ToTokenProperty
			   name: #'border-color-primary-selection'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'list-context-menu-selection-border-gap'
			   value: 1.0) }
]

{ #category : #accessing }
ToTheme class >> label [

	^ 'Unsupported abstract theme'
]

{ #category : #accessing }
ToTheme class >> technicalTokenProperties [
	" toplo need a list of unique stamps for widget technical parameters. "

	^ {  }
]

{ #category : #accessing }
ToTheme >> addTokenProperties: aCollection [

	tokenProperties addAll: aCollection
]

{ #category : #accessing }
ToTheme >> addTokenProperty: aTokenProperty [

	tokenProperties add: aTokenProperty
]

{ #category : #accessing }
ToTheme >> defaultSkinFor: anElement [

	anElement skinManager setUp: anElement forTheme: self.
	^ self expectedSkinFor: anElement
]

{ #category : #accessing }
ToTheme >> defaultTokenProperties [

	^ self class defaultTokenProperties
]

{ #category : #accessing }
ToTheme >> expectedSkinFor: anElement [

	^ anElement skinManager ifNotNil: [:sm | sm defaultSkin ]
]

{ #category : #accessing }
ToTheme >> icons [

	^ icons
]

{ #category : #accessing }
ToTheme >> icons: aThemeIcons [

	icons := aThemeIcons
]

{ #category : #initialization }
ToTheme >> initialize [

	super initialize.
	tokenProperties := self technicalTokenProperties asOrderedCollection.
	tokenProperties addAll: self defaultTokenProperties
]

{ #category : #accessing }
ToTheme >> name [

	^ self class label
]

{ #category : #accessing }
ToTheme >> newSkinFor: anElement [

	anElement ensuredSkinManager setUp: anElement forTheme: self.
	^ self newSkinInstanceFor: anElement
]

{ #category : #accessing }
ToTheme >> newSkinInstanceFor: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToTheme >> onInstalledIn: anElement [

	anElement toThemePreInstall: self.
	anElement addAllTokenProperties: self tokenProperties.
	anElement toThemeInstalled
]

{ #category : #'api - hooks' }
ToTheme >> onUninstalledIn: anElement [

	anElement removeAllTokenPropertiesFromNames: (self tokenProperties collect: [:tp | tp name]).
	anElement toThemeUninstalled: self
]

{ #category : #printing }
ToTheme >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' [ ';
		nextPutAll: self name;
		nextPutAll: ' ]'
]

{ #category : #hook }
ToTheme >> setUpElement: anElement [
]

{ #category : #styling }
ToTheme >> styleSheet [ 

	^ nil
]

{ #category : #accessing }
ToTheme >> technicalTokenProperties [

	^ self class technicalTokenProperties
]

{ #category : #accessing }
ToTheme >> tokenProperties [

	^ tokenProperties 
]
