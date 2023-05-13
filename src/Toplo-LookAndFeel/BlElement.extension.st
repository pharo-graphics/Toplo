Extension { #name : #BlElement }

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

	self userData at: #ToTheme put: aTheme.
	self toThemeChanged
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ]
]
