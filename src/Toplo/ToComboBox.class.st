Class {
	#name : #ToComboBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#selectedIndex => ObservableSlot',
		'#listElement',
		'#listFrame',
		'#headElement',
		'#listElementSize',
		'#mode => ObservableSlot'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'mode change' }
ToComboBox >> beDataEditing [

	self mode: ToComboBoxDataEditingMode new
]

{ #category : #'mode change' }
ToComboBox >> beInlineAutocomplete [

	self mode: (ToComboBoxDataEditingMode new
			 inlineAutocomplete: true;
			 yourself)
]

{ #category : #'mode change' }
ToComboBox >> beSelectOnly [

	self mode: ToComboBoxSelectOnlyMode new
]

{ #category : #testing }
ToComboBox >> canInsertData: aData [

	^ true
]

{ #category : #events }
ToComboBox >> clickOnDataEvent: aClickOnDataEvent [

	self selectIndex: aClickOnDataEvent index.
	self closeEvent: aClickOnDataEvent event.
	self requestFocus
]

{ #category : #displaying }
ToComboBox >> closeEvent: anEvent [

	self isOpened ifFalse: [ ^ self ].
	self listFrame close
]

{ #category : #accessing }
ToComboBox >> data [

	^ self listElement data
]

{ #category : #'t - initialization dresser' }
ToComboBox >> defaultDresser [

	^ ToComboBoxDresser new
]

{ #category : #initialization }
ToComboBox >> defaultHeadElement [

	^ self mode defaultHeadElement
]

{ #category : #initialization }
ToComboBox >> defaultListElement [

	^ ToListElement new
		  preserveSelectionOnFocused: false;
		  yourself
]

{ #category : #initialization }
ToComboBox >> defaultListElementSize [

		^ 250@230
]

{ #category : #initialization }
ToComboBox >> defaultListFrame [

	| win |
	win := ToAnchoredWindow new widget: self.
	win hook: [ :w :event | self bounds inSpace bottomLeft ].
	win root layout: BlFrameLayout new.
	win root fitContent.
	win root addChild: self listElement.
	^ win
]

{ #category : #initialization }
ToComboBox >> defaultListPlaceholder [

	^ ToLabel new
		  vFitContent;
		  margin: (BlInsets all: 5);
		  width: self listElementSize x;
		  constraintsDo: [ :c | c maxHeight: self listElementSize y ];
		  alignCenter;
		  yourself
]

{ #category : #initialization }
ToComboBox >> defaultMode [

	^ ToComboBoxDataEditingMode new
	"^ ToComboBoxSelectOnlyMode new"
]

{ #category : #initialization }
ToComboBox >> defaultStartSelectedIndex [

	^ 1

	
]

{ #category : #initialization }
ToComboBox >> fitListElementToContent [

	self listElement
		vFitContent;
		in: [ :e | e infinite vFitContent ];
		width: self listElementSize x;
		maxHeight: self listElementSize y.
	self listFrame 	root fitContent.
	self listElement next elevation: (BlRelativeElevation elevation: SmallInteger maxVal).

]

{ #category : #testing }
ToComboBox >> hasSelectedData [

	^ self selectedIndex > 0
]

{ #category : #accessing }
ToComboBox >> headElement [

	^ headElement
]

{ #category : #accessing }
ToComboBox >> headElementFactory: aValuable [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	self dispatchEvent: (ToComboBoxHeadElementFactoryChangeEvent new factory: aValuable)
]

{ #category : #accessing }
ToComboBox >> headPlaceholder: anElement [

	self dispatchEvent: (ToComboBoxHeadPlaceholderChangeEvent new
			 placeholder: anElement;
			 yourself)
]

{ #category : #accessing }
ToComboBox >> indexOfData: aData [

	^ self data indexOf: aData ifAbsent: [ 0 ]
]

{ #category : #initialization }
ToComboBox >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self listElementSize: self defaultListElementSize.
	self listPlaceholder: self defaultListPlaceholder.
	self fitListElementToContent.
	self listElement showPlaceholder.
	self whenModeChangedDo: [ :new :prev | self mode: prev changedWith: new ].
]

{ #category : #accessing }
ToComboBox >> insertData: aData [

	| idx |
	idx := self indexOfData: aData.
	idx isZero ifTrue: [
		self data add: aData.
		idx := self indexOfData: aData ].
	self fitListElementToContent.
	self selectIndex: idx
]

{ #category : #testing }
ToComboBox >> isClosed [

	^ self isOpened not
]

{ #category : #testing }
ToComboBox >> isOpened [ 

	^ self listFrame isAttachedToSceneGraph
]

{ #category : #accessing }
ToComboBox >> listElement [

	^ listElement
]

{ #category : #'api - install/uninstall  hook' }
ToComboBox >> listElementRequestFocus [

	self listElement infinite requestFocus
]

{ #category : #accessing }
ToComboBox >> listElementSize [

	^ listElementSize
]

{ #category : #accessing }
ToComboBox >> listElementSize: aSize [

	listElementSize := aSize.
	self listPlaceholder: self defaultListPlaceholder.
	self fitListElementToContent 
]

{ #category : #accessing }
ToComboBox >> listFrame [

	^ listFrame
]

{ #category : #accessing }
ToComboBox >> listPlaceholder: anElement [

	self listElement placeholder: anElement
]

{ #category : #accessing }
ToComboBox >> mode [

	^ mode
]

{ #category : #accessing }
ToComboBox >> mode: aComboBoxMode [

	mode := aComboBoxMode
]

{ #category : #'mode change' }
ToComboBox >> mode: previousMode changedWith: newMode [

	self privateHeadElement: self defaultHeadElement.
	self updateHeadContent
]

{ #category : #accessing }
ToComboBox >> nodeFactory [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	^ self listElement nodeFactory
]

{ #category : #accessing }
ToComboBox >> nodeFactory: aConverter [

	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "
	self listElement nodeFactory: aConverter
]

{ #category : #'private - notifications' }
ToComboBox >> notifyChanged [

	self dispatchEvent: ToComboBoxChangedEvent new
]

{ #category : #displaying }
ToComboBox >> placeholderHidden [

	self fitListElementToContent.
	listElement next parentDo: [ :p | ^ self ].
	listElement addChild: listElement next
]

{ #category : #displaying }
ToComboBox >> placeholderShown [

	listElement size: self listElementSize.
	listElement next removeFromParent
]

{ #category : #displaying }
ToComboBox >> popupEvent: anEvent [

	self isOpened ifTrue: [ ^ self ].
	self listFrame popupEvent: anEvent.
	"self selectIndex: self selectedIndex"
]

{ #category : #displaying }
ToComboBox >> popupOrCloseEvent: anEvent [

	self isOpened
		ifTrue: [ self closeEvent: anEvent ]
		ifFalse: [ self popupEvent: anEvent ]
]

{ #category : #'t - initialization dresser' }
ToComboBox >> preInitializeDresser [ 

	super preInitializeDresser.
	self mode: self defaultMode.
	self privateListElement: self defaultListElement.
	self privateListFrame: self defaultListFrame.
	self privateHeadElement: self defaultHeadElement.


]

{ #category : #'private - accessing' }
ToComboBox >> privateHeadElement: anElement [

	headElement = anElement ifTrue: [ ^ self ].
	headElement ifNotNil: [ headElement removeFromParent ].
	headElement := anElement.
	self selectIndex: self selectedIndex.
	self addChild: headElement
]

{ #category : #'private - accessing' }
ToComboBox >> privateListElement: aListElement [

	listElement := aListElement
]

{ #category : #'private - accessing' }
ToComboBox >> privateListFrame: aWindow [

	listFrame := aWindow
]

{ #category : #'private - accessing' }
ToComboBox >> privateSelectedIndex: anInteger [

	selectedIndex := anInteger
]

{ #category : #accessing }
ToComboBox >> scrollToIndex: anIndex [

	self listElement scrollToIndex: anIndex
]

{ #category : #accessing }
ToComboBox >> selectData: aData [

	| prev curr |
	prev := self selectedIndex.
	curr := self data indexOf: aData.
	self privateSelectedIndex: curr.
	prev = curr ifFalse: [ self updateHeadContent ].
	self selectedIndex isZero ifTrue: [ ^ self ].
	listElement whenLayoutedDoOnce: [
		self listElement selectIndex: self selectedIndex ].
	self requestLayout
]

{ #category : #accessing }
ToComboBox >> selectIndex: anIndex [

	| prev |
	prev := self selectedIndex.
	self privateSelectedIndex: anIndex.
	self updateHeadContent.
	self selectedIndex isZero ifTrue: [ ^ self ].
	listElement whenLayoutedDoOnce: [
		self listElement selectIndex: self selectedIndex ].
	self requestLayout
]

{ #category : #accessing }
ToComboBox >> selectedData [
	
	^ self data at: self selectedIndex 
]

{ #category : #accessing }
ToComboBox >> selectedDataDo: aBlock [
	
	self hasSelectedData ifFalse: [ ^ self ].
	aBlock value: self selectedData
]

{ #category : #accessing }
ToComboBox >> selectedIndex [
	
	^ selectedIndex ifNil: [ selectedIndex := 0 ]
]

{ #category : #'change hook' }
ToComboBox >> updateHeadContent [

	self dispatchEvent: ToComboBoxSelectedIndexChangeEvent new 
]

{ #category : #'change hook' }
ToComboBox >> whenModeChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #mode whenChangedDo: aBlock
]

{ #category : #'change hook' }
ToComboBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]
