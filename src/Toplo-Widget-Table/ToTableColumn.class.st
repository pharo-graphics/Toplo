"
I represent how a column should be rendered.

- DataIndex is the accessors to call to get the field to render from a data
"
Class {
	#name : #ToTableColumn,
	#superclass : #Object,
	#instVars : [
		'title',
		'dataIndex',
		'key',
		'renderBlock'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableColumn >> dataIndex [

	^ dataIndex
]

{ #category : #accessing }
ToTableColumn >> dataIndex: anObject [

	dataIndex := anObject
]

{ #category : #initialization }
ToTableColumn >> defaultRenderBlock [

	^ [ :value | ToLabel text: value ]
]

{ #category : #initialization }
ToTableColumn >> initialize [

	super initialize.
	renderBlock := self defaultRenderBlock
]

{ #category : #accessing }
ToTableColumn >> key [

	^ key
]

{ #category : #accessing }
ToTableColumn >> key: anObject [

	key := anObject
]

{ #category : #rendering }
ToTableColumn >> render: aDataItem [
	
	^ self renderBlock value: (self retrieveDataFromDataIndex: aDataItem)
]

{ #category : #accessing }
ToTableColumn >> renderBlock [

	^ renderBlock
]

{ #category : #accessing }
ToTableColumn >> renderBlock: anObject [

	renderBlock := anObject
]

{ #category : #rendering }
ToTableColumn >> retrieveDataFromDataIndex: aDataItem [

	| result |
	dataIndex isString ifTrue: [
		^ aDataItem perform: self dataIndex asSymbol ].
	self dataIndex isFullBlock ifTrue: [ ^ self dataIndex value: aDataItem ].
	result := aDataItem perform: self dataIndex first asSymbol.
	dataIndex allButFirstDo: [ :symbol |
		result := result perform: symbol asSymbol ].
	^ result
]

{ #category : #accessing }
ToTableColumn >> title [

	^ title
]

{ #category : #accessing }
ToTableColumn >> title: anObject [

	title := anObject
]
