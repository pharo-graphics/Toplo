Class {
	#name : #ToAbstractMultiSelectDataItem,
	#superclass : #Object,
	#instVars : [
		'bar'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> bar [

	^ bar
]

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> bar: aBarElement [

	bar := aBarElement
]

{ #category : #testing }
ToAbstractMultiSelectDataItem >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> nodesCount [

	^ self subclassResponsibility
]
