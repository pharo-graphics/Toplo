Class {
	#name : #ToComboBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#data',
		'#selectedIndex => ObservableSlot',
		'#listElement',
		'#listFrame',
		'#headElement',
		'#mode'
	],
	#category : #'Toplo-Widget-ComboBox'
}

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

	^ data
]

{ #category : #accessing }
ToComboBox >> data: aCollection [

	data := aCollection
]

{ #category : #'api - change hook' }
ToComboBox >> dataIndexOf: aData [

	^ self data indexOf: aData ifAbsent: [ 0 ]
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
]

{ #category : #initialization }
ToComboBox >> defaultListElementSize [

		^ 250@130
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
		  width: self defaultListElementSize x;
		  constraintsDo: [ :c | c maxHeight: self defaultListElementSize y ];
		  alignCenter;
		  yourself
]

{ #category : #initialization }
ToComboBox >> defaultMode [

	^ ToComboBoxDataEditingMode new
]

{ #category : #initialization }
ToComboBox >> defaultStartSelectedIndex [

	^ 1

	
]

{ #category : #testing }
ToComboBox >> hasSelectedData [

	^ self selectedIndex > 0
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

{ #category : #initialization }
ToComboBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	self mode: self defaultMode.
	self privateData: self newDataCollection.
	self layout: self defaultLayout.
	self privateHeadElement: self defaultHeadElement.
	self privateListElement: self defaultListElement.
	self privateListFrame: self defaultListFrame.
	self prepareListElement.
	self listPlaceholder: self defaultListPlaceholder.
	self selectIndex: 0.
	self listElement showPlaceholder.
	self initializeDresser
]

{ #category : #accessing }
ToComboBox >> insertData: aData [

	| idx |
	idx := self dataIndexOf: aData.
	idx isZero ifTrue: [
		self data add: aData.
		idx := self dataIndexOf: aData ].
	self prepareListElement.
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

	self isOpened ifTrue: [
		self listElement infinite requestFocus ]
]

{ #category : #accessing }
ToComboBox >> listElementSize: aSize [

	self listElement size: aSize
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
	self presentedData
		replaceFrom: anAnnouncement interval first
		to: anAnnouncement interval last
		with: self data list
		startingAt: anAnnouncement interval first
]

{ #category : #'private - notifications' }
ToComboBox >> notifyDataInserted: anAnnouncement [

	anAnnouncement interval ifEmpty: [ ^ self ].
	self presentedData addAll: (self data
			 copyFrom: anAnnouncement interval first
			 to: anAnnouncement interval last)
]

{ #category : #'private - notifications' }
ToComboBox >> notifyDataRemoved: anAnnouncement [

	anAnnouncement interval ifEmpty: [ ^ self ].
	self presentedData
		removeFrom: anAnnouncement interval first
		to: anAnnouncement interval last
]

{ #category : #displaying }
ToComboBox >> placeholderHidden [

	self prepareListElement.
	listElement next parentDo: [ :p | ^ self ].
	listElement addChild: listElement next
]

{ #category : #displaying }
ToComboBox >> placeholderShown [

	listElement size: self defaultListElementSize.
	listElement next removeFromParent
]

{ #category : #displaying }
ToComboBox >> popupEvent: anEvent [

	self isOpened ifTrue: [ ^ self ].
	self listFrame popupEvent: anEvent.
	self selectIndex: self selectedIndex
]

{ #category : #displaying }
ToComboBox >> popupOrCloseEvent: anEvent [

	self isOpened
		ifTrue: [ self closeEvent: anEvent ]
		ifFalse: [ self popupEvent: anEvent ]
]

{ #category : #initialization }
ToComboBox >> prepareListElement [

	self listElement
		vFitContent;
		in: [ :e | e infinite vFitContent ];
		width: self defaultListElementSize x;
		maxHeight: self defaultListElementSize y.
	self listFrame 	root fitContent.
	self listElement next elevation: (BlRelativeElevation elevation: SmallInteger maxVal).

]

{ #category : #accessing }
ToComboBox >> presentedData [

	^ listElement data
]

{ #category : #'private - accessing' }
ToComboBox >> privateData: anObservableCollection [

	anObservableCollection whenAddChangeDo: [ :ann | self notifyDataInserted: ann ].
	anObservableCollection whenRemoveChangeDo: [ :ann | self notifyDataRemoved: ann ].
	anObservableCollection whenUpdateChangeDo: [ :ann | self notifyDataInserted: ann ].
	data := anObservableCollection.

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

{ #category : #'private - accessing' }
ToComboBox >> privateSelectedIndex: anInteger [

	selectedIndex := anInteger
]

{ #category : #accessing }
ToComboBox >> scrollToIndex: anIndex [

	self listElement scrollToIndex: anIndex
]

{ #category : #accessing }
ToComboBox >> selectIndex: anIndex [

	| prev |
	prev := self selectedIndex.
	self privateSelectedIndex: anIndex.
	prev = anIndex ifFalse: [
		self dispatchEvent: ToComboBoxSelectedIndexChangeEvent new ].
	anIndex isZero ifTrue: [ ^ self ].
	listElement whenLayoutedDoOnce: [
		self listElement selectIndex: self selectedIndex ]
]

{ #category : #accessing }
ToComboBox >> selectedData [
	
	^ self presentedData at: self selectedIndex 
]

{ #category : #accessing }
ToComboBox >> selectedDataDo: aBlock [
	
	self hasSelectedData ifFalse: [ ^ self ].
	aBlock value: self selectedData
]

{ #category : #accessing }
ToComboBox >> selectedIndex [
	
	^ selectedIndex 
]

{ #category : #'change hook' }
ToComboBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]
