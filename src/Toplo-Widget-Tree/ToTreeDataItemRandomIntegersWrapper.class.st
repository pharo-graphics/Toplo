Class {
	#name : #ToTreeDataItemRandomIntegersWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemRandomIntegersWrapper >> determineChildren [

	^ 1 to: (Random new nextIntegerBetween: 0 and: 4).
]
