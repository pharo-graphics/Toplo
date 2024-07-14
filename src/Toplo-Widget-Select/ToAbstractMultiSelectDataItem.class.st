Class {
	#name : #ToAbstractMultiSelectDataItem,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #testing }
ToAbstractMultiSelectDataItem >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> nodesCount [

	^ self subclassResponsibility
]
