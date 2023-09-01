"
A variable to access environment fonts (defined in `StandardFonts class`).
This variable must be used to assign the attribute `name` of a `ToStyleFont` property.
"
Class {
	#name : #ToStyleEnvironmentFontVariable,
	#superclass : #ToStyleEnvironmentVariable,
	#category : #'Toplo-StyleSheet'
}

{ #category : #documentation }
ToStyleEnvironmentFontVariable class >> documentExampleCode [

	^ 'Font { #name: EnvironmentFont(#default) }'
]

{ #category : #documentation }
ToStyleEnvironmentFontVariable class >> documentValidValues [

	^ StandardFonts class selectors 
		select: [ :each | each endsWith: 'Font' ]
		thenCollect: [ :each | each allButLast: 4 ]
]

{ #category : #'ston-core' }
ToStyleEnvironmentFontVariable class >> stonName [

	^ 'EnvironmentFont'
]

{ #category : #accessing }
ToStyleEnvironmentFontVariable >> familyName [

	^ self value familyName
]

{ #category : #accessing }
ToStyleEnvironmentFontVariable >> name [

	^ super name ifNil: [ #default ]
]

{ #category : #accessing }
ToStyleEnvironmentFontVariable >> pointSize [

	^ self value pointSize
]

{ #category : #evaluating }
ToStyleEnvironmentFontVariable >> value [
	^ self name = 'default' 
		ifTrue: [ StandardFonts defaultFont ]
		ifFalse: [ StandardFonts perform: (self name, 'Font') asSymbol ]
]
