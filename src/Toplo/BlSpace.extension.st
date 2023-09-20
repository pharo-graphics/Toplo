Extension { #name : 'BlSpace' }

{ #category : '*Toplo' }
BlSpace >> checkRootSkinInstallation [

	self root privateSkin ifNotNil: [ ^ self ].
	
	self root withSkin: self root defaultSkin.
	" To preserve efficiency, #launchSkinInstallation does nothing by default at BlElement level."
	" Thus, the installation for root is directly launched here "
	self root privateSkin launchSkinInstallationIn: self root
]

{ #category : '*Toplo' }
BlSpace >> checkSkinInstallation [

	
	self checkRootSkinInstallation.
	self root checkSkinInstallation
]

{ #category : '*Toplo' }
BlSpace >> checkSpaceFrameSkinInstallationPhase [

	| layoutPhase |
	(self frame phases anySatisfy: [ :p |
		 p isKindOf: ToSpaceFrameSkinInstallationPhase ]) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase "
	layoutPhase := self frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	self frame addPhase: ToSpaceFrameSkinInstallationPhase new before: layoutPhase
]

{ #category : '*Toplo' }
BlSpace >> defaultPopupElevation [

	^ BlRelativeElevation elevation: SmallInteger maxVal
]

{ #category : '*Toplo' }
BlSpace >> openAsPopup: anElement [

	anElement elevation: self defaultPopupElevation.
	self root addChild: anElement
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self root toTheme
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self root toTheme: aTheme
]
