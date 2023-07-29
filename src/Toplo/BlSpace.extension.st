Extension { #name : #BlSpace }

{ #category : #'*Toplo' }
BlSpace >> defaultPopupElevation [

	^ BlRelativeElevation elevation: SmallInteger maxVal
]

{ #category : #'*Toplo-LookAndFeel' }
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

	(self toTheme isNil or:[self toTheme isSupportLightAndDark not]) ifTrue:[ ^ self ].

	newTheme := self toTheme isLight
			 ifTrue: [ self toTheme darkTheme ]
			 ifFalse: [ self toTheme lightTheme ].
			
	newTheme ifNil:[ ^ self ].
	self toTheme: newTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	| theme |
	theme := self root toTheme.

	"Check theme installation : this is dirty and temporary"
	(theme notNil and:[self isThemeInstalled not]) ifTrue:[ theme installOnSpace: self ].
	
	^ theme
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	aTheme ifNotNil: [ aTheme installOnSpace: self ].
	self root toTheme: aTheme
]
