"
I'm a provider that redirects to the default Pharo icon provider.
"
Class {
	#name : #ToPharoThemeIconProvider,
	#superclass : #ToIconProvider,
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToPharoThemeIconProvider >> iconNamed: aName [ 

	^ self 
		iconNamed: aName 
		ifAbsent: [ self noIcon ]
]

{ #category : #accessing }
ToPharoThemeIconProvider >> iconNamed: aName ifAbsent: aBlock [

	aName ifNil: [ ^ aBlock value ].

	^ ThemeIcons current 
		iconNamed: aName 
		ifNone: aBlock
]

{ #category : #accessing }
ToPharoThemeIconProvider >> noIcon [

	^ ThemeIcons current blankIcon
]
