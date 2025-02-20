Class {
	#name : #ToTreeDataItemSubclassesAndMethodsWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemSubclassesAndMethodsWrapper >> computedChildren [

	^ dataItem isClass
		  ifTrue: [
			  | newCollection |
			  newCollection := dataItem subclasses asOrderedCollection.
			  newCollection addAll:
				  (dataItem methods collect: [ :each | each selector ]) sorted.
			  newCollection ]
		  ifFalse: [ OrderedCollection empty ]
]
