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
		'cellFactory',
		'headerCellFactory',
		'cellBuilder',
		'headerCellBuilder',
		'sorterContainerBuilder'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #rendering }
ToTableColumn >> buildHeaderCellInContainer: anHeaderCellContainer inTableElement: aTableElement [

	width ifNotNil: [ anHeaderCellContainer width: width ].
	
	useCheckbox ifTrue: [
			| cbox |
			cbox := aTableElement newHeaderCheckboxInColumn: self.
			cbox constraintsDo: [ :c | c linear vertical alignCenter ].
			anHeaderCellContainer ensureStartContainer.
			anHeaderCellContainer startContainer addChild: cbox ].

	anHeaderCellContainer cell constraintsDo: [ :c |
		c horizontal matchParent ].

	headerCellBuilder
		cull: anHeaderCellContainer cell
		cull: self
		cull: aTableElement
]

{ #category : #rendering }
ToTableColumn >> buildListCellInContainer: aCellContainer atIndex: aColumnIndex inNode: aTableNode [

	| cellData state |
	state := aTableNode holder listElement cellStateAt: aColumnIndex.
	state width ifNotNil: [ :w | aCellContainer width: w ].
	cellData := self fetchedCellDataFromDataIndex:
		            aTableNode holder dataItem.
	useCheckbox ifTrue: [
			| tableListElement cbox |
			tableListElement := aTableNode holder listElement.
			cbox := tableListElement newCheckboxInNode: aTableNode.
			cbox constraintsDo: [ :c | c linear vertical alignCenter ].
			aCellContainer ensureStartContainer.
			aCellContainer startContainer addChild: cbox ].
	aCellContainer cell constraintsDo: [ :c | c horizontal matchParent ].
	cellBuilder
		cull: aCellContainer cell
		cull: cellData
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
ToTableColumn >> cellFactory [

	^ cellFactory ifNil: [ cellFactory := self defaultCellFactory ]
]

{ #category : #accessing }
ToTableColumn >> cellFactory: anObject [

	cellFactory := anObject
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
ToTableColumn >> defaultCellFactory [

	^ [ :holder | ToTableListCell new ]
]

{ #category : #initialization }
ToTableColumn >> defaultHeaderCellBuilder [

	^ [ :element :column |
	  element addChild: (ToLabel text: column title asString) ]
]

{ #category : #initialization }
ToTableColumn >> defaultHeaderCellFactory [

	^ [ ToTableHeaderCell new ]
]

{ #category : #initialization }
ToTableColumn >> defaultSortDirection [

	^ ToSortDirection both
]

{ #category : #initialization }
ToTableColumn >> defaultSorterContainerBuilder [
	" aValuable takes 3 optional arguments: the element to build, the column and the table element"

	^ [ :sorterContainer :column :table |
		  | arrow |
		  arrow := ToIconicArrowButton new.
		  column updateArrowOrientation: arrow.
		  sorterContainer addChild: arrow.
		  arrow clickAction: [
				  column nextSort.
				  column updateArrowOrientation: arrow.
				  table header dispatchEvent:
					  (ToTableSortRequestEvent column: column) ] ]
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

{ #category : #accessing }
ToTableColumn >> headerCellFactory [

	^ headerCellFactory ifNil: [
		  headerCellFactory := self defaultHeaderCellFactory ]
]

{ #category : #accessing }
ToTableColumn >> headerCellFactory: anObject [

	headerCellFactory := anObject
]

{ #category : #initialization }
ToTableColumn >> initialize [

	super initialize.
	headerCellBuilder := self defaultHeaderCellBuilder.
	cellBuilder := self defaultCellBuilder.
	sorterContainerBuilder := self defaultSorterContainerBuilder.
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
ToTableColumn >> sorterContainerBuilder [

	^ sorterContainerBuilder
]

{ #category : #accessing }
ToTableColumn >> sorterContainerBuilder: aValuable [

	sorterContainerBuilder := aValuable
]

{ #category : #accessing }
ToTableColumn >> title [

	^ title
]

{ #category : #accessing }
ToTableColumn >> title: anObject [

	title := anObject
]

{ #category : #sorting }
ToTableColumn >> updateArrowOrientation: arrow [

	self sortOrder = #ascending ifTrue: [ ^ arrow beDown ].
	self sortOrder = #descending ifTrue: [ ^ arrow beUp ].
	^ arrow beRight 
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
