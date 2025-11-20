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
		'resizable',
		'dataViewBuilder',
		'headerViewBuilder',
		'startDragWidth',
		'useCheckbox'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #rendering }
ToTableColumn >> buildCellElement: anElement inNode: aTableNode [

	| cellData |
	width ifNotNil: [ anElement width: width ].
	cellData := self fetchedCellDataFromDataIndex:
		            aTableNode holder dataItem.
	useCheckbox
		ifTrue: [
				self
					buildCheckableCellElement: anElement
					inNode: aTableNode
					withData: cellData ]
		ifFalse: [
				self
					buildSimpleCellElement: anElement
					inNode: aTableNode
					withData: cellData ].

	anElement childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ]
]

{ #category : #rendering }
ToTableColumn >> buildCheckableCellElement: anElement inNode: aTableNode withData: aColumnData [

	| tableListElement innerElement cbox |
	tableListElement := aTableNode holder listElement.
	cbox := tableListElement newCheckboxInNode: aTableNode.
	innerElement := ToElement new
		                hMatchParent;
		                vFitContent.
	innerElement layout: BlLinearLayout horizontal.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	innerElement constraintsDo: [ :c | c linear vertical alignCenter ].
	anElement addChild: cbox.
	anElement addChild: innerElement.

	dataViewBuilder
		cull: innerElement
		cull: aColumnData
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
ToTableColumn >> buildSimpleCellElement: anElement inNode: aTableNode withData: aColumnData [

	dataViewBuilder
		cull: anElement
		cull: aColumnData
		cull: aTableNode holder
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

{ #category : #rendering }
ToTableColumn >> fetchedCellDataFromDataIndex: aDataItem [

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
	sortDirections := self defaultSortDirection.
	resizable := true.
	useCheckbox := false
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
ToTableColumn >> resizable [

	^ resizable
]

{ #category : #accessing }
ToTableColumn >> resizable: aBoolean [

	resizable := aBoolean
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
ToTableColumn >> startDragWidth [

	^ startDragWidth
]

{ #category : #accessing }
ToTableColumn >> startDragWidth: aWidth [

	startDragWidth := aWidth
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
ToTableColumn >> useCheckbox [ 

	^ useCheckbox
]

{ #category : #accessing }
ToTableColumn >> useCheckbox: aBoolean [

	useCheckbox := aBoolean
]

{ #category : #accessing }
ToTableColumn >> width [

	^ width 
]

{ #category : #accessing }
ToTableColumn >> width: aNumber [

	width := aNumber
]
