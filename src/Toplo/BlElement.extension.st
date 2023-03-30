Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> toTheme [

	^ self userData
		at: #ToTheme
		ifAbsent: [ self hasParent
				ifTrue: [ self parent toTheme ]
				ifFalse: [ self userData	at: #ToTheme put: ToTheme default. self toTheme ] ]
]

{ #category : #'*Toplo' }
BlElement >> toTheme: aTheme [

	self userData at: #ToTheme put: aTheme.
	self toThemeChanged
]

{ #category : #'*Toplo' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ]
]
