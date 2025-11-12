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
		'sorterBlock',
		'sortDirections',
		'sortOrder',
		'width',
		'dataViewBuilder',
		'headerViewBuilder'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #rendering }
ToTableColumn >> buildDataView: anElement fromNode: aTableNode [

	| columnData |
	width ifNotNil: [ anElement width: width ].
	columnData := self columnDataFromDataIndex:
		              aTableNode holder dataItem.
	dataViewBuilder
		cull: anElement
		cull: columnData
		cull: aTableNode holder
]

{ #category : #rendering }
ToTableColumn >> buildHeaderView: anElement [

	width ifNotNil: [ anElement width: width ].
	headerViewBuilder
		cull: anElement
		cull: self
]

{ #category : #rendering }
ToTableColumn >> columnDataFromDataIndex: aDataItem [

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
ToTableColumn >> dataIndex [

	^ dataIndex
]

{ #category : #accessing }
ToTableColumn >> dataIndex: anObject [

	dataIndex := anObject
]

{ #category : #accessing }
ToTableColumn >> dataViewBuilder [

	^ dataViewBuilder
]

{ #category : #accessing }
ToTableColumn >> dataViewBuilder: aValuable [
	" aValuable takes 3 optional arguments: the element to build, the data and the node holder "

	dataViewBuilder := aValuable
]

{ #category : #initialization }
ToTableColumn >> defaultDataViewBuilder [

	^ [ :element :dataItem :holder |
	  element addChild: (ToLabel text: dataItem asString) ]
]

{ #category : #initialization }
ToTableColumn >> defaultHeaderBuilder [

	^ [ :element :column |
	  element addChild: (ToLabel text: column title asString) ]
]

{ #category : #initialization }
ToTableColumn >> defaultSortDirection [

	^ ToSortDirection both
]

{ #category : #accessing }
ToTableColumn >> headerViewBuilder [

	^ headerViewBuilder
]

{ #category : #accessing }
ToTableColumn >> headerViewBuilder: aValuable [
	" aValuable takes 2 optional arguments: the element to build and the column "

	headerViewBuilder := aValuable
]

{ #category : #initialization }
ToTableColumn >> initialize [

	super initialize.
	headerViewBuilder := self defaultHeaderBuilder.
	dataViewBuilder := self defaultDataViewBuilder.
	sortDirections := self defaultSortDirection
]

{ #category : #accessing }
ToTableColumn >> key [

	^ key
]

{ #category : #accessing }
ToTableColumn >> key: anObject [

	key := anObject
]

{ #category : #sorting }
ToTableColumn >> nextSort [
	"order is nil -> ascend -> descend -> nil"

	sortDirections isSortNone ifTrue: [ ^ self ].
	sortOrder ifNil: [ "ascend then descend"
			sortDirections hasSortAscend ifTrue: [ ^ sortOrder := #ascending ].
			sortDirections hasSortDescend ifTrue: [ ^ sortOrder := #descending ] ].

	sortOrder = #ascending ifTrue: [ "descend then nil"
		sortDirections hasSortDescend ifTrue: [ ^ sortOrder := #descending ] ].
	"default if descending or if ascending but cannot decending"
	^ sortOrder := nil
]

{ #category : #accessing }
ToTableColumn >> sortDirections [
	"Supported sort way could be ascend, descend, both or none"

	^ sortDirections
]

{ #category : #accessing }
ToTableColumn >> sortDirections: anObject [

	sortDirections := anObject
]

{ #category : #accessing }
ToTableColumn >> sortOrder [

	^ sortOrder
]

{ #category : #accessing }
ToTableColumn >> sortOrder: anObject [

	^ sortOrder := anObject
]

{ #category : #sorting }
ToTableColumn >> sorterBlock [
	"nil mean this column do not support sorting. Not nil mean there is at least on sorting possible"

	^ sorterBlock
]

{ #category : #sorting }
ToTableColumn >> sorterBlock: aValuable [

	sorterBlock := aValuable
]

{ #category : #accessing }
ToTableColumn >> title [

	^ title
]

{ #category : #accessing }
ToTableColumn >> title: anObject [

	title := anObject
]

{ #category : #accessing }
ToTableColumn >> width [

	^ width 
]

{ #category : #accessing }
ToTableColumn >> width: aNumber [

	width := aNumber
]
