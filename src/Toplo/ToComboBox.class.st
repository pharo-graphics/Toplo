Class {
	#name : #ToComboBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#listElement',
		'#listFrame',
		'#headElement',
		'#listElementSize',
		'#data',
		'#saveAllowed',
		'#mode => ObservableSlot',
		'#selectedIndex => ObservableSlot',
		'#defaultDataProvider'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'mode change' }
ToComboBox >> beDataEditing [

	self mode: ToComboBoxEditableMode new
]

{ #category : #'mode change' }
ToComboBox >> beInlineAutocomplete [

	self mode: (ToComboBoxEditableMode new
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

{ #category : #displaying }
ToComboBox >> close [

	self isOpened ifFalse: [ ^ self ].
	self listFrame close.
	self requestFocus
]

{ #category : #displaying }
ToComboBox >> closeEvent: anEvent [

	self close
]

{ #category : #accessing }
ToComboBox >> data [

	^ data
]

{ #category : #accessing }
ToComboBox >> defaultDataProvider [

	^ defaultDataProvider
]

{ #category : #accessing }
ToComboBox >> defaultDataProvider: aValuable [
	" aValuable takes the combo-box as optional argument "

	defaultDataProvider := aValuable
]

{ #category : #'t - initialization dresser' }
ToComboBox >> defaultDresser [

	^ ToComboBoxDresser new
]

{ #category : #initialization }
ToComboBox >> defaultHeadElement [

	^ self mode defaultHeadElementIn: self
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

	^ nil
]

{ #category : #initialization }
ToComboBox >> defaultMode [

	^ ToComboBoxSelectOnlyMode new
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
	selectedIndex := 0.
	saveAllowed := false.
	self mode: self defaultMode.
	self privateListFrame: self defaultListFrame.
	self privateHeadElement: self defaultHeadElement.
	self privateData: self newDataCollection.
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
		| prev |
		prev := self data copy.
		self data removeAll.
		prev add: aData.
		self data addAll: prev asArray sorted.
		idx := self indexOfData: aData ].
	self fitListElementToContent.
	self selectedIndex: idx
]

{ #category : #testing }
ToComboBox >> isClosed [

	^ self isOpened not
]

{ #category : #testing }
ToComboBox >> isOpened [ 

	^ self listFrame isAttachedToSceneGraph
]

{ #category : #events }
ToComboBox >> listClickedEvent: aClickEvent [

	self selectIndexInPresentedData: self listElement selectedIndex.
	self close
]

{ #category : #accessing }
ToComboBox >> listElement [

	^ listElement
]

{ #category : #displaying }
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

{ #category : #events }
ToComboBox >> listNodeSelectedEvent: aClickOnDataEvent [

	"| idx clickIdx |
	clickIdx := aClickOnDataEvent index.
	idx := (self listElement selectedIndexes includes: clickIdx)
		       ifTrue: [ clickIdx ]
		       ifFalse: [ 0 ].
	self selectIndexInPresentedData: idx"
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

	self privateHeadElement: self defaultHeadElement
]

{ #category : #initialization }
ToComboBox >> newDataCollection [

	^ ToObservableCollection new
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

{ #category : #'private - notifications' }
ToComboBox >> notifyDataChanged: anAnnouncement [

	anAnnouncement interval ifEmpty: [ ^ self ].
	self flag: 'todo'.

	"self presentedData
		replaceFrom: anAnnouncement interval first
		to: anAnnouncement interval last
		with: self data list
		startingAt: anAnnouncement interval first"
]

{ #category : #'private - notifications' }
ToComboBox >> notifyDataInserted: anAnnouncement [

	anAnnouncement interval ifEmpty: [ ^ self ].
	self presentedData removeAll.
	self presentedData addAll: self data asArray
]

{ #category : #'private - notifications' }
ToComboBox >> notifyDataRemoved: anAnnouncement [

	anAnnouncement interval ifEmpty: [ ^ self ].
	self flag: 'todo'.
	"self presentedData
		removeFrom: anAnnouncement interval first
		to: anAnnouncement interval last"
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
	self data ifEmpty: [ self listElement placeholder ifNil: [ ^ self ]  ].
	self listFrame popupEvent: anEvent
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
	self privateListElement: self defaultListElement.



]

{ #category : #accessing }
ToComboBox >> presentedData [

	^ listElement data
]

{ #category : #'private - accessing' }
ToComboBox >> privateData: anObservableCollection [

	data := anObservableCollection.
	anObservableCollection whenAddChangeDo: [ :ann | self notifyDataInserted: ann ].
	anObservableCollection whenRemoveChangeDo: [ :ann | self notifyDataRemoved: ann ].
	anObservableCollection whenUpdateChangeDo: [ :ann | self notifyDataInserted: ann ].
	
	self notifyChanged
]

{ #category : #'private - accessing' }
ToComboBox >> privateHeadElement: anElement [

	headElement = anElement ifTrue: [ ^ self ].
	headElement ifNotNil: [ headElement removeFromParent ].
	headElement := anElement.
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

{ #category : #accessing }
ToComboBox >> saveAllowed [

	^ saveAllowed
]

{ #category : #accessing }
ToComboBox >> saveAllowed: aBoolean [

	aBoolean = saveAllowed ifTrue: [ ^ self ].
	saveAllowed := aBoolean.
	self privateHeadElement: self defaultHeadElement
]

{ #category : #accessing }
ToComboBox >> selectIndex: anIndex [

	self selectedIndex: anIndex.
	self mode selectIndex: anIndex in: self
]

{ #category : #accessing }
ToComboBox >> selectIndexInPresentedData: anIndex [

	| idx |
	idx := anIndex isZero
		       ifTrue: [ 0 ]
		       ifFalse: [ self data indexOf: (self presentedData at: anIndex) ].
	self selectIndex: idx
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

{ #category : #accessing }
ToComboBox >> selectedIndex: anIndex [

	selectedIndex = anIndex ifTrue: [ ^ self ].
	selectedIndex := anIndex.
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
