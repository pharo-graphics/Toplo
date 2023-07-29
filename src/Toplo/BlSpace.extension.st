Extension { #name : #BlSpace }

{ #category : #'*Toplo' }
BlSpace >> checkRootSkinInstallation [

	self root privateSkin ifNil: [ 
		self root withSkin: ToSpaceRootSkin new].
	" To preserve efficiency, #launchSkinInstallation does nothing by default at BlElement level."
	" Thus, the installation for root is directly launched here "
	self root privateSkin launchSkinInstallationIn: self root
]

{ #category : #'*Toplo' }
BlSpace >> checkSkinInstallation [

	
	self checkRootSkinInstallation.
	self root checkSkinInstallation
]

{ #category : #'*Toplo' }
BlSpace >> checkSpaceFrameSkinInstallationPhase [

	(self frame phases anySatisfy: [ :p |
		 p isKindOf: ToSpaceFrameSkinInstallationPhase ]) ifTrue: [ ^ self ].
	self frame addPhase: ToSpaceFrameSkinInstallationPhase new
]

{ #category : #'*Toplo' }
BlSpace >> defaultPopupElevation [

	^ BlRelativeElevation elevation: SmallInteger maxVal
]

{ #category : #'*Toplo' }
BlSpace >> isSupportToTheme [
	"Development method : to check if the Space support ToTheme management"

	^ self root toTheme isNil
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> isThemeInstalled [
	"This method is temporary here to detect when a Theme is installed, this is dirty and a Space need to have a dresser pattern"
	
	self flag:'laborded : this is necessary to have this state for the first instanciation, this is temporary'.
	^ self root userData at: #isToThemeInstalled ifAbsentPut:[ false ]
]

{ #category : #'*Toplo' }
BlSpace >> openAsPopup: anElement [

	anElement elevation: self defaultPopupElevation.
	self root addChild: anElement
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> switchThemeDarkOrLight [
	"Switch to the opposite theme : dark or light (if available)"
	| newTheme |
	Toplo useLookAndFeel ifFalse: [ ^ self ].
	(self toTheme isNil or:[self toTheme isSupportLightAndDark not]) ifTrue:[ ^ self ].

	newTheme := self toTheme isLight
			 ifTrue: [ self toTheme darkTheme ]
			 ifFalse: [ self toTheme lightTheme ].
			
	newTheme ifNil:[ ^ self ].
	self toTheme: newTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self root toTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self root toTheme: aTheme.
	Toplo useLookAndFeel ifFalse: [ ^ self ].
	aTheme installOnSpace: self.
]
