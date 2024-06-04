Class {
	#name : #ToMultiSelectCompositeDataItem,
	#superclass : #ToAbstractMultiSelectDataItem,
	#instVars : [
		'dataItems',
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

	dataItems := aCollection
]

{ #category : #testing }
ToMultiSelectCompositeDataItem >> isComposite [

	^ true
]

{ #category : #accessing }
ToMultiSelectCompositeDataItem >> nodesCount [ 

	| count |
	count := 0.
	dataItems do: [ :d |
		count := count + d nodesCount ].
	^ count
]
