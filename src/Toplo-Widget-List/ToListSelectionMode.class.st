Class {
	#name : #ToListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'beneathOption',
		'overOption',
		'elementClass',
		'selecter',
		'primary',
		'requestFocusOnMouseDown',
		'preserveSelectionOnFocused',
		'selectOnMouseDown',
		'multiple',
		'enabled',
		'selectionElementSizeHook',
		'selectionElementPositionHook'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionMode class >> new [

	^ self shouldNotImplement
]

{ #category : #'instance creation' }
ToListSelectionMode class >> primary [

	| primary |
	primary := self basicNew.
	primary primary: true.
	primary initialize.
	^ primary
]

{ #category : #'instance creation' }
ToListSelectionMode class >> secondary [

	| secondary |
	secondary := self basicNew.
	secondary primary: false.
	secondary initialize.
	^ secondary
]

{ #category : #testing }
ToListSelectionMode >> allowRequestFocusOnMouseDown [

	| max |
	self isDisabled ifTrue: [ ^ self requestFocusOnMouseDown ].
	max := self isMultipleSelection
		       ifTrue: [ 1 ]
		       ifFalse: [ 0 ].
	self selectedIndexesCount > max ifTrue: [
		self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ self requestFocusOnMouseDown
]

{ #category : #accessing }
ToListSelectionMode >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListSelectionMode >> beSingleSelection [

	self multiple: false
]

{ #category : #accessing }
ToListSelectionMode >> beneathOption [

	^ beneathOption
]

{ #category : #accessing }
ToListSelectionMode >> beneathOption: aListSelectionOption [

	beneathOption := aListSelectionOption
]

{ #category : #initialization }
ToListSelectionMode >> defaultElementClass [

	^ primary
		  ifTrue: [ ToListPrimarySelectionElement ]
		  ifFalse: [ ToListSecondarySelectionElement ]
]

{ #category : #accessing }
ToListSelectionMode >> disable [

	self enabled: false
]

{ #category : #accessing }
ToListSelectionMode >> elementClass [

	^ elementClass 
]

{ #category : #accessing }
ToListSelectionMode >> elementClass: aSelectionElementClass [

	elementClass := aSelectionElementClass
]

{ #category : #accessing }
ToListSelectionMode >> enable [

	self enabled: true
]

{ #category : #accessing }
ToListSelectionMode >> enabled [

	^ enabled
]

{ #category : #accessing }
ToListSelectionMode >> enabled: aBoolean [
 
	enabled = aBoolean ifTrue: [ ^ self ].
	enabled := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter enabled: aBoolean
]

{ #category : #initialization }
ToListSelectionMode >> initialize [ 

	super initialize.
	beneathOption := ToListSelectionOption grouped.
	overOption := ToListSelectionOption none.
	elementClass := self defaultElementClass.
	requestFocusOnMouseDown := true.
	preserveSelectionOnFocused := true.
	selectOnMouseDown := false.
	multiple := true.
	enabled := true
]

{ #category : #testing }
ToListSelectionMode >> isDisabled [

	^ self enabled not
]

{ #category : #testing }
ToListSelectionMode >> isEnabled [

	^ self enabled
]

{ #category : #testing }
ToListSelectionMode >> isMultipleSelection [

	^ multiple
]

{ #category : #testing }
ToListSelectionMode >> isPrimarySelectionMode [

	^ primary
]

{ #category : #accessing }
ToListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToListSelectionMode >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListSelectionMode >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter multiple: aBoolean
]

{ #category : #accessing }
ToListSelectionMode >> nodeEventHandlerClasses [

	^ self isMultipleSelection
		  ifTrue: [ { ToListNodeMultiSelectionClickEventHandler } ]
		  ifFalse: [ { ToListNodeSingleSelectionClickEventHandler } ]
]

{ #category : #accessing }
ToListSelectionMode >> onAddedNode: aNode [

	self nodeEventHandlerClasses do: [ :cls | aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToListSelectionMode >> onClickEvent: anEvent onNode: aNode [

	self isDisabled ifTrue: [ ^ self ].
	self isMultipleSelection ifTrue: [
		self onMultiSelectionClickEvent: anEvent onNode: aNode.
		^ self ].
	self onSingleSelectionClickEvent: anEvent onNode: aNode
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onInstalledIn: anElement [

	selecter := self isPrimarySelectionMode 
		ifTrue: [ ToPrimarySelecter new ]
		ifFalse: [ ToSecondarySelecter new ].

	selecter
		  enabled: self enabled;
		  multiple: self isMultipleSelection.
		
	selecter onInstalledIn: anElement
]

{ #category : #'event handling' }
ToListSelectionMode >> onMultiSelectionClickEvent: anEvent onNode: aNode [

	anEvent sourceEvent modifiers isShift ifTrue: [
		| curr |
		curr := self selecter currentIndex.
		self selecter selectIndex: curr to: aNode holder position.
		^ self ].
	(anEvent sourceEvent modifiers isPrimaryModifier or: [
		 self selectOnMouseDown ]) ifTrue: [
		self selectOrDeselectOnNode: aNode.
		^ self ].
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #accessing }
ToListSelectionMode >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 self nodeEventHandlerClasses anySatisfy: [ :cls |
			 cls inheritsFrom: ToListNodeSelectionEventHandler ] ]) do: [ :handler |
		aNode removeEventHandler: handler ]
]

{ #category : #'event handling' }
ToListSelectionMode >> onSingleSelectionClickEvent: anEvent onNode: aNode [

	(anEvent sourceEvent modifiers isPrimaryModifier or: [
		 self selectOnMouseDown ]) ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onUninstalledIn: anElement [

	selecter onUninstalledIn: anElement.
	selecter := nil
]

{ #category : #accessing }
ToListSelectionMode >> operator [

	^ selecter operator
]

{ #category : #accessing }
ToListSelectionMode >> overOption [

	^ overOption
]

{ #category : #accessing }
ToListSelectionMode >> overOption: aListSelectionOption [

	overOption := aListSelectionOption
]

{ #category : #accessing }
ToListSelectionMode >> positionFrom: aPoint forSelectionElement: aSelectionElement [

	^ selectionElementPositionHook
		  ifNil: [ aPoint ]
		  ifNotNil: [ :ph | ph value: aSelectionElement value: aPoint ]
]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #accessing }
ToListSelectionMode >> primary: aBoolean [

	selecter ifNotNil: [ Error signal: 'The selecter kind can''t be changed' ].
	primary := aBoolean

]

{ #category : #accessing }
ToListSelectionMode >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown
]

{ #category : #accessing }
ToListSelectionMode >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean 
]

{ #category : #accessing }
ToListSelectionMode >> selectOnMouseDown [

	^ selectOnMouseDown
]

{ #category : #accessing }
ToListSelectionMode >> selectOnMouseDown: aBoolean [

	selectOnMouseDown := aBoolean
]

{ #category : #'event handling' }
ToListSelectionMode >> selectOrDeselectOnNode: aNode [

	| index target |
	index := aNode holder position.
	target := aNode holder listElement.
	(target selectionModel containsIndex: index)
		ifTrue: [ self selecter deselectIndex: index ]
		ifFalse: [ self selecter selectIndex: index ]
]

{ #category : #accessing }
ToListSelectionMode >> selectedIndexes [

	^ self selectionModel indexes
]

{ #category : #accessing }
ToListSelectionMode >> selectedIndexesCount [

	^ self selectionModel selectedIndexesCount
]

{ #category : #accessing }
ToListSelectionMode >> selecter [

	^ selecter 
]

{ #category : #accessing }
ToListSelectionMode >> selectionElementPositionHook: aValuable [

	" 
	Computes the selection element position according to the selected node position.
	aValuable takes the selected node position as first arg and return the selection element position to use. 
	"
	selectionElementPositionHook := aValuable
]

{ #category : #accessing }
ToListSelectionMode >> selectionElementSizeHook: aValuable [

	" 
	Computes the selection element size according to the selected node size.
	aValuable takes the selected node size as first arg and return the selection element size to use. 
	"

	selectionElementSizeHook := aValuable
]

{ #category : #accessing }
ToListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #accessing }
ToListSelectionMode >> sizeFrom: aPoint forSelectionElement: aSelectionElement [

	^ selectionElementSizeHook
		  ifNil: [ aPoint ]
		  ifNotNil: [ :ph | ph value: aSelectionElement value: aPoint ]
]
