Extension { #name : #BlSpace }

{ #category : #'*Toplo' }
BlSpace >> checkSkinInstallation [

	self rootSkinInstalled ifFalse: [
		self root withSkin: self root defaultSkin ].
	self root checkSkinInstallation
]

{ #category : #'*Toplo' }
BlSpace >> checkSpaceFrameSkinInstallationPhase [
	| layoutPhase |

	(self frame phases anySatisfy: [ :p |
		 p isKindOf: ToSpaceFrameSkinInstallationPhase ]) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase "
	layoutPhase := self frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	self frame addPhase: ToSpaceFrameSkinInstallationPhase new before: layoutPhase
]

{ #category : #'*Toplo' }
BlSpace >> rootSkinInstalled [

	^ self root privateSkin notNil

]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self root toTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self root toTheme: aTheme
]
