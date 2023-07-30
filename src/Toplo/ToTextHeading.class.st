Class {
	#name : #ToTextHeading,
	#superclass : #Object,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #'instance creation' }
ToTextHeading class >> number: aNumber [

	aNumber = 1 ifTrue: [ ^ ToTextH1 new ].
	aNumber = 2 ifTrue: [ ^ ToTextH2 new ].
	aNumber = 3 ifTrue: [ ^ ToTextH3 new ].
	aNumber = 4 ifTrue: [ ^ ToTextH4 new ].
	aNumber = 5 ifTrue: [ ^ ToTextH5 new ].
	^ ToTextH0 new
	
]

{ #category : #accessing }
ToTextHeading >> fontSizeIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToTextHeading >> headingNumber [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToTextHeading >> lineHeightIn: anElement [

	^ self subclassResponsibility 
]
