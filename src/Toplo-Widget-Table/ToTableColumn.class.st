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
		'useCheckbox',
		'cellBuilder',
		'headerCellBuilder'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #rendering }
ToTableColumn >> buildCheckableHeaderCellElement: anElement inTableElement: aTableElement [

	| innerElement cbox |
	cbox := aTableElement newHeaderCheckboxInColumn: self.
	innerElement := ToElement new
		                hMatchParent;
		                vFitContent.
	innerElement layout: BlLinearLayout horizontal.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	innerElement constraintsDo: [ :c | c linear vertical alignCenter ].
	anElement addChild: cbox.
	anElement addChild: innerElement.

	headerCellBuilder cull: innerElement cull: self cull: aTableElement
]

{ #category : #rendering }
ToTableColumn >> buildCheckableListCellElement: anElement inNode: aTableNode withData: aColumnData [

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

	cellBuilder
		cull: innerElement
		cull: aColumnData
		cull: aTableNode holder
]

{ #category : #rendering }
ToTableColumn >> buildHeaderCellElement: anElement inTableElement: aTableElement [

	width ifNotNil: [ anElement width: width ].
	useCheckbox
		ifTrue: [
				self
					buildCheckableHeaderCellElement: anElement
					inTableElement: aTableElement ]
		ifFalse: [
				self
					buildSimpleHeaderCellElement: anElement
					inTableElement: aTableElement ].

	anElement childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ]
]

{ #category : #rendering }
ToTableColumn >> buildListCellElement: anElement atIndex: aColumnIndex inNode: aTableNode [

	| cellData state |
	state := aTableNode holder listElement cellStateAt: aColumnIndex.
	state width ifNotNil: [:w | anElement width: w ].
	cellData := self fetchedCellDataFromDataIndex:
		            aTableNode holder dataItem.
	useCheckbox
		ifTrue: [
				self
					buildCheckableListCellElement: anElement
					inNode: aTableNode
					withData: cellData ]
		ifFalse: [
				self
					buildSimpleListCellElement: anElement
					inNode: aTableNode
					withData: cellData ].


	anElement childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ]
]

{ #category : #rendering }
ToTableColumn >> buildSimpleHeaderCellElement: anElement inTableElement: aTableElement [

	headerCellBuilder cull: anElement cull: self cull: aTableElement
]

{ #category : #rendering }
ToTableColumn >> buildSimpleListCellElement: anElement inNode: aTableNode withData: aColumnData [

	cellBuilder
		cull: anElement
		cull: aColumnData
		cull: aTableNode holder
]

{ #category : #accessing }
ToTableColumn >> cellBuilder [

	^ cellBuilder
]

{ #category : #accessing }
ToTableColumn >> cellBuilder: aValuable [
	" aValuable takes 3 optional arguments: the element to build, the data and the node holder "

	cellBuilder := aValuable
]

{ #category : #accessing }
ToTableColumn >> dataIndex [

	^ dataIndex
]

{ #category : #accessing }
ToTableColumn >> dataIndex: anObject [

	dataIndex := anObject
]

{ #category : #initialization }
ToTableColumn >> defaultCellBuilder [

	^ [ :element :dataItem :holder |
	  element addChild: (ToLabel text: dataItem asString) ]
]

{ #category : #initialization }
ToTableColumn >> defaultHeaderCellBuilder [

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
ToTableColumn >> headerCellBuilder [

	^ headerCellBuilder
]

{ #category : #accessing }
ToTableColumn >> headerCellBuilder: aValuable [
	" aValuable takes 3 optional arguments: the element to build, the column and the table element"

	headerCellBuilder := aValuable
]

{ #category : #initialization }
ToTableColumn >> initialize [

	super initialize.
	headerCellBuilder := self defaultHeaderCellBuilder.
	cellBuilder := self defaultCellBuilder.
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

	sortOrder := anObject
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
