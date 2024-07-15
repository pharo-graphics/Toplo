Class {
	#name : #ToAbstractMultiSelectDataItem,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> indexes [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractMultiSelectDataItem >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> nodesCount [

	^ self subclassResponsibility
]
