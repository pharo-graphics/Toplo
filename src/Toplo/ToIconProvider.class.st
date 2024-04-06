"
I'm base icon provider. 
Children of `ToIconProvider` will define concrete ways to access icons.
"
Class {
	#name : #ToIconProvider,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #copying }
ToIconProvider >> , aProvider [

	^ ToCompositeIconProvider new 
		addProvider: self;
		addProvider: aProvider;
		yourself
]

{ #category : #accessing }
ToIconProvider >> iconNamed: aName [

	^ self 
		iconNamed: aName 
		ifAbsent: [ self error: ('Icon {1} not found.' format: { aName })  ]
]

{ #category : #accessing }
ToIconProvider >> iconNamed: aName ifAbsent: aBlock [

	self subclassResponsibility
]
