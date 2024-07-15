Class {
	#name : #ToMultiSelectCompositeDataItem,
	#superclass : #ToAbstractMultiSelectDataItem,
	#instVars : [
		'dataItems',
		'indexes',
		'content'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> content [

	^ content
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> content: anObject [

	content := anObject
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> dataItems [

	^ dataItems
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> dataItems: aCollection [

	dataItems := aCollection asArray
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> index [

	^ -1
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> indexes [

	^ indexes
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> indexes: aCollection [

	indexes := aCollection asArray
]

{ #category : #testing }
ToMultiSelectCompositeDataItem >> isComposite [

	^ true
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> nodesCount [ 
	
	^ dataItems size
]
