"
I am the main entry point to reprensent a Table based on the [ant design](https://ant.design/components/table)
"
Class {
	#name : #ToTableElement,
	#superclass : #ToElement,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#columns => ObservableSlot',
		'#showHeader => ObservableSlot',
		'#header',
		'#list',
		'#dividersUpdateRequested',
		'#columnContainers'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTableElement >> addDivider: aDivider atIndex: anIndex [

	aDivider cellIndex: anIndex.
	self addChild: aDivider.
	aDivider elevation: (BlRelativeElevation elevation: 20 + anIndex).
	aDivider setPositionInTable
]

{ #category : #accessing }
ToTableElement >> columnContainers [

	^ self selectChildrenWithId: #columnContainer
]

{ #category : #accessing }
ToTableElement >> columnStateAt: anIndex [

	^ header columnStateAt: anIndex
]

{ #category : #accessing }
ToTableElement >> columns [

	^ columns
]

{ #category : #accessing }
ToTableElement >> columns: aTableColumnArray [

	columns := aTableColumnArray
]

{ #category : #accessing }
ToTableElement >> dataAccessor [

	^ self list dataAccessor
]

{ #category : #initialization }
ToTableElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout vertical
]

{ #category : #accessing }
ToTableElement >> header [

	^ header
]

{ #category : #accessing }
ToTableElement >> header: anObject [

	header := anObject
]

{ #category : #accessing }
ToTableElement >> indexOfColumn: aColumn [

	^ columns indexOf: aColumn
]

{ #category : #initialization }
ToTableElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	dividersUpdateRequested := false.
	self matchParent.
	self padding: (BlInsets all: 1).
	self initializeHeader.
	self addChild: header.
	self initializeList.
	self addChild: list.

	self property: #columns whenChangedDo: [
			list columns: self columns.
			header initializeWithColumns: self columns.
			self initializeColumnContainers.
			self addChildren: columnContainers.
			header initializeDividers.
			list notifyDataSourceChanged ].

	self property: #showHeader whenChangedDo: [
			showHeader
				ifTrue: [ header constraintsDo: [ :c | c vertical fitContent ] ]
				ifFalse: [ header constraintsDo: [ :c | c vertical exact: 0.0 ] ] ].

	self addEventHandler: ToTableElementEventHandler new
]

{ #category : #initialization }
ToTableElement >> initializeColumnContainers [

	columnContainers ifNotNil: [ self removeChildren: columnContainers ].
	columnContainers := OrderedCollection new.
	self columns withIndexDo: [ :column :idx |
			| colContainer headerCell |
			colContainer := ToTableColumnContainer new
				                column: column;
				                yourself.
			headerCell := header cellContainerAt: idx.
			colContainer constraintsDo: [ :c |
					c vertical matchParent.
					c ignoreByLayout.
					c anchors add:
						(c anchors topAnchor on: list topAnchor).
					c anchors add: (c anchors heightAnchor on:
							 list heightAnchor).
					c anchors add:
						(c anchors leftAnchor on: headerCell leftAnchor).
					c anchors add:
						(c anchors widthAnchor on: headerCell widthAnchor) ].
			column containerBuilder cull: colContainer cull: self cull: self.
			columnContainers add: colContainer ]
]

{ #category : #initialization }
ToTableElement >> initializeDividers [

	| containers index |
	self removeDividers.
	containers := self header cellContainers.
	index := 0.
	containers overlappingPairsDo: [ :first :second |
			| col |
			index := index + 1.
			col := columns at: index.
			col resizable ifTrue: [
				self addDivider: self newDivider atIndex: index ] ].
	self requestDividersUpdate
]

{ #category : #initialization }
ToTableElement >> initializeHeader [

	header := self newHeaderElement
		          elevation: (BlRelativeElevation elevation: 10);
		          parentTable: self;
		          yourself
]

{ #category : #initialization }
ToTableElement >> initializeList [

	list := self newListElement
		        id: #list;
		        parentTable: self;
		        elevation: (BlRelativeElevation elevation: 10);
		        addStamp: #background withValue: Color transparent;
		        yourself
]

{ #category : #accessing }
ToTableElement >> list [

	^ list
]

{ #category : #accessing }
ToTableElement >> list: anObject [

	list := anObject
]

{ #category : #initialization }
ToTableElement >> newDivider [

	^ ToTableDivider new
		  id: #columnDivider;
		  parentTable: self;
		  yourself
]

{ #category : #'event handling' }
ToTableElement >> newHeaderCheckbox [

	| cbox |
	cbox := list newCheckbox.
	cbox allowIndeterminate: true.
	cbox switchToNextCheckStateOnClick: false.
	self updateHeaderCheckboxForListSelection: cbox.

	" In case the checkbox has been clicked, update the list selection "
	cbox
		addEventHandlerOn: BlClickEvent
		do: [ :event | self updateListSelectionFromHeaderCheckbox: cbox ].

	list
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | self updateHeaderCheckboxForListSelection: cbox ].

	^ cbox
]

{ #category : #initialization }
ToTableElement >> newHeaderElement [

	^ ToTableHeaderElement new
]

{ #category : #initialization }
ToTableElement >> newListElement [

	^ ToTableListElement new
]

{ #category : #accessing }
ToTableElement >> nodeManager [

	^ list nodeManager
]

{ #category : #'hooks - layout' }
ToTableElement >> onLayoutDone [

	super onLayoutDone.
	dividersUpdateRequested ifTrue: [ self updateDividers ]
]

{ #category : #initialization }
ToTableElement >> otherDividersUpdate: aDivider [

	| dividers |
	dividers := self selectChildrenWithId: #columnDivider.
	dividers do: [ :div | div ~= aDivider ifTrue: [div setPositionInTable ] ]
]

{ #category : #initialization }
ToTableElement >> recordCellsWidth [

	header recordCellsWidth.
	list recordCellsWidth
]

{ #category : #initialization }
ToTableElement >> removeColumnContainers [

	self columnContainers do: [ :c | c removeFromParent ]
]

{ #category : #initialization }
ToTableElement >> removeDividers [

	| dividers |
	dividers := self selectChildrenWithId: #columnDivider.
	dividers do: [ :d | d removeFromParent ]
]

{ #category : #'hooks - layout' }
ToTableElement >> requestDividersUpdate [

	dividersUpdateRequested := true.
	self requestLayout
]

{ #category : #accessing }
ToTableElement >> selecter [

	^ self list selecter
]

{ #category : #accessing }
ToTableElement >> showHeader: aBoolean [

	showHeader := aBoolean
]

{ #category : #initialization }
ToTableElement >> updateDividers [

	| dividers |
	dividers := self selectChildrenWithId: #columnDivider.
	dividers do: [ :div | div setPositionInTable ].
	dividersUpdateRequested := false
]

{ #category : #'event handling' }
ToTableElement >> updateHeaderCheckboxForListSelection: aCheckbox [

	(list selectionModel isNotEmpty and: [
		 list selectionModel selectedIndexesCount = list dataAccessor itemCount ])
		ifTrue: [ aCheckbox checked: true ]
		ifFalse: [
				list selectionModel isEmpty
					ifTrue: [ aCheckbox checked: false ]
					ifFalse: [ aCheckbox checked: #indeterminate ] ]
]

{ #category : #'event handling' }
ToTableElement >> updateListSelectionFromHeaderCheckbox: aCheckbox [

	(aCheckbox isIndeterminate or: [ aCheckbox isChecked not ])
		ifTrue: [ list selecter selectAll ]
		ifFalse: [ list selecter deselectAll ]
]

{ #category : #'selection updating' }
ToTableElement >> updateSelectionAfter: aValuable [

	list updateSelectionAfter: aValuable
]

{ #category : #accessing }
ToTableElement >> useCheckbox: aBoolean [

	list useCheckbox: aBoolean.
	header useCheckbox: aBoolean
	
]
