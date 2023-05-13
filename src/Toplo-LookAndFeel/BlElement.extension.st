Extension { #name : #BlElement }

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> openInOBlSpaceWithoutToTheme [
	"This is a development method : use this method when your Space cannot support ToTheme management"
	| sp |
	sp := OBlSpace new.
	sp toTheme: nil.
	sp root addChild: self.
	sp show.
	^ sp

]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme [

	^ self userData at: #ToTheme ifAbsent: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [ ToAbstractTheme current ] 
	]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	| currentTheme |
	currentTheme := self userData at: #ToTheme ifAbsent:[ nil ].
	currentTheme == aTheme ifTrue:[ ^ self ].
	
	self userData at: #ToTheme put: aTheme.
	self toThemeChanged
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ]
]
