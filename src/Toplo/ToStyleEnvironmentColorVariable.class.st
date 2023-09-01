"
A variable to access environment colors (defined in `UITheme` and subclasses) 
"
Class {
	#name : #ToStyleEnvironmentColorVariable,
	#superclass : #ToStyleEnvironmentVariable,
	#category : #'Toplo-StyleSheet'
}

{ #category : #documentation }
ToStyleEnvironmentColorVariable class >> documentExampleCode [

	^ 'Draw { #color: EnvironmentColor(#background) }'
]

{ #category : #documentation }
ToStyleEnvironmentColorVariable class >> documentValidValues [

	^ UITheme selectors
		select: [ :each | 
			(each endsWith: 'Color') 
				and: [ ((UITheme current perform: each) isKindOf: Color) ] ]
		thenCollect: [ :each | each allButLast: 5 ]
]

{ #category : #'ston-core' }
ToStyleEnvironmentColorVariable class >> stonName [

	^ 'EnvironmentColor'
]

{ #category : #evaluating }
ToStyleEnvironmentColorVariable >> value [

	self name ifNil: [ ^ nil ].
	"because they can change when we change the theme"
	^ ToStyleEnvironmentColorProxy new 
		colorSelector: (self name, 'Color') asSymbol;
		yourself
]

{ #category : #evaluating }
ToStyleEnvironmentColorVariable >> valueAsColor [
	
	^ self value
]
