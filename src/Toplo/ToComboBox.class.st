Class {
	#name : #ToComboBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#data',
		'#selectedIndex => ObservableSlot',
		'#listElement',
		'#listPlaceholder',
		'#listFrame',
		'#headElement',
		'#headPlaceholder',
		'#headContentFactory => ObservableSlot'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #events }
ToComboBox >> clickOnDataEvent: aClickOnDataEvent [

	self selectIndex: aClickOnDataEvent index.
	self closeEvent: aClickOnDataEvent event.
	self requestFocus
]

{ #category : #displaying }
ToComboBox >> closeEvent: anEvent [

	self listFrame isAttachedToSceneGraph ifFalse: [ ^ self ].
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

{ #category : #'t - initialization dresser' }
ToComboBox >> defaultDresser [

	^ ToComboBoxDresser new
]

{ #category : #initialization }
ToComboBox >> defaultHeadContentFactory [

	^ [ :d | ToLabel text: d ]
]

{ #category : #initialization }
ToComboBox >> defaultHeadElement [

	^ ToComboBoxHead new matchParent
]

{ #category : #initialization }
ToComboBox >> defaultHeadPlaceholder [

	^ ToLabel new text: ('<< No choice >>' asRopedText foreground: Color gray)
]

{ #category : #initialization }
ToComboBox >> defaultListElement [

	^ ToListElement new
		  vFitContent;
		  width: self defaultListElementSize x;
		  maxHeight: self defaultListElementSize y;
		  nodeFactory: self defaultListNodeFactory;
		  yourself
]

{ #category : #initialization }
ToComboBox >> defaultListElementSize [

		^ 250@350
]

{ #category : #initialization }
ToComboBox >> defaultListFrame [
	| win |
	win := ToPopupWindow new widget: self.
	win root layout: BlFrameLayout new.
	win root fitContent.
	win root addChild: self listElement.
	^  win
]

{ #category : #initialization }
ToComboBox >> defaultListNodeFactory [

	^ [ :d |
	  ToLabeledNode new
		  beLabelFirst;
		  hMatchParent;
		  labelText: d;
		  yourself ]
]

{ #category : #initialization }
ToComboBox >> defaultListPlaceholder [

	^ ToLabel new
		  text: ('<< Empty >>' asRopedText foreground: Color gray);
		  vFitContent;
		  margin: (BlInsets all: 5);
		  width: self defaultListElementSize x;
		  constraintsDo: [ :c | c maxHeight: self defaultListElementSize y ];
		  alignCenter;
		  yourself
]

{ #category : #initialization }
ToComboBox >> defaultStartSelectedIndex [

	^ 1

	
]

{ #category : #accessing }
ToComboBox >> headContentFactory [
	" a Valuable can take 2 args, a selected data value and the previous button"

	^ headContentFactory
]

{ #category : #accessing }
ToComboBox >> headContentFactory: aValuable [
	" a Valuable can take 2 args, a selected data value and the previous head"

	headContentFactory := aValuable
]

{ #category : #'change hook' }
ToComboBox >> headContentFactoryChanged [

	self selectedIndex isZero ifTrue: [
		self useHeadPlaceholder.
		^ self ].
	self headData: (self presentedData at: self selectedIndex).
	self listElement selectIndex: self selectedIndex
]

{ #category : #accessing }
ToComboBox >> headData: aData [

	self headElementContent: (self headContentFactory cull: aData cull: self headElement)
]

{ #category : #accessing }
ToComboBox >> headElement [

	^ headElement
]

{ #category : #accessing }
ToComboBox >> headElement: anElement [

	headElement = anElement ifTrue: [ ^ self ].
	headElement ifNotNil: [ headElement removeFromParent ].
	headElement := anElement.
	self addChild: headElement
]

{ #category : #accessing }
ToComboBox >> headElementContent: anElement [

	headElement contentElement: anElement
]

{ #category : #accessing }
ToComboBox >> headPlaceholder [

	^ headPlaceholder
]

{ #category : #accessing }
ToComboBox >> headPlaceholder: anElement [

	headPlaceholder := anElement.
	self selectedIndex ifNil: [^ self].
	self selectedIndex isZero ifTrue: [ self useHeadPlaceholder ]
]

{ #category : #displaying }
ToComboBox >> hideListPlaceholder [

	self listPlaceholder parentDo: [ :p |
		self listPlaceholder removeFromParent.
		self listFrame root addChild: self listElement]
]

{ #category : #displaying }
ToComboBox >> hideOrShowListPlaceholder [

	self data ifEmpty: [ ^ self showListPlaceholder ].
	self hideListPlaceholder
]

{ #category : #initialization }
ToComboBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	self privateData: self newDataCollection.
	self layout: self defaultLayout.
	self headElement: self defaultHeadElement.
	self headPlaceholder: self defaultHeadPlaceholder.
	self listPlaceholder: self defaultListPlaceholder.
	self headContentFactory: self defaultHeadContentFactory.
	self listElement: self defaultListElement.
	self listFrame: self defaultListFrame.
	self whenSelectedIndexChangedDo: [ self selectedIndexChanged ].
	self whenHeadContentFactoryChangedChangedDo: [ self headContentFactoryChanged  ].
	self selectIndex: 0.
	self showListPlaceholder.
	self initializeDresser
]

{ #category : #accessing }
ToComboBox >> listElement [

	^ listElement
]

{ #category : #accessing }
ToComboBox >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #initialization }
ToComboBox >> listElementSize: aSize [

	self listElement size: aSize
]

{ #category : #accessing }
ToComboBox >> listFrame [

	^ listFrame
]

{ #category : #initialization }
ToComboBox >> listFrame: aWindow [

	listFrame := aWindow
]

{ #category : #accessing }
ToComboBox >> listNodeFactory [

	^ self listElement nodeFactory
]

{ #category : #accessing }
ToComboBox >> listNodeFactory: aBlock [

	self listElement nodeFactory: aBlock
]

{ #category : #accessing }
ToComboBox >> listPlaceholder [

	^ listPlaceholder
]

{ #category : #accessing }
ToComboBox >> listPlaceholder: anElement [

	listPlaceholder ifNotNil: [
		listPlaceholder parentDo: [ :p |
			listPlaceholder removeFromParent.
			listPlaceholder := anElement.
			self listFrame root addChild: listPlaceholder.
			^ self ] ].
	listPlaceholder := anElement
]

{ #category : #initialization }
ToComboBox >> newDataCollection [

	^ ToObservableCollection new
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
	self hideOrShowListPlaceholder.
	self presentedData addAll: (self data
			 copyFrom: anAnnouncement interval first
			 to: anAnnouncement interval last)
]

{ #category : #'private - notifications' }
ToComboBox >> notifyDataRemoved: anAnnouncement [

	anAnnouncement interval ifEmpty: [ ^ self ].
	self hideOrShowListPlaceholder.
	self presentedData
		removeFrom: anAnnouncement interval first
		to: anAnnouncement interval last
]

{ #category : #displaying }
ToComboBox >> popupEvent: anEvent [

	self listFrame isAttachedToSceneGraph ifTrue: [ ^ self ].
	self listFrame popupEvent: anEvent.
	self listElement requestFocus
]

{ #category : #displaying }
ToComboBox >> popupOrCloseEvent: anEvent [

	self listFrame isAttachedToSceneGraph
		ifTrue: [ self closeEvent: anEvent ]
		ifFalse: [ self popupEvent: anEvent ]
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

{ #category : #accessing }
ToComboBox >> selectIndex: anIndex [

	anIndex isZero ifTrue: [
		self useHeadPlaceholder.
		^ self ].
	self headData: (self presentedData at: anIndex).
	self listElement selectIndex: anIndex.
	self selectedIndex: anIndex
]

{ #category : #accessing }
ToComboBox >> selectedIndex [
	
	^ selectedIndex 
]

{ #category : #accessing }
ToComboBox >> selectedIndex: anInteger [

	selectedIndex := anInteger
]

{ #category : #'change hook' }
ToComboBox >> selectedIndexChanged [


]

{ #category : #displaying }
ToComboBox >> showListPlaceholder [

	self listPlaceholder parentDo: [ :p | ^ self ].
	self listFrame root addChild: self listPlaceholder.
	self listFrame root removeChild: self listElement
]

{ #category : #accessing }
ToComboBox >> useHeadPlaceholder [

	self headElementContent: self headPlaceholder.
	self listElement clearSelection.
	self selectedIndex: 0
]

{ #category : #'change hook' }
ToComboBox >> whenHeadContentFactoryChangedChangedDo: aBlock [

	"set a block to perform after that the place holder has been changed, and its action performed"

	self property: #headContentFactory whenChangedDo: aBlock
]

{ #category : #'change hook' }
ToComboBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]
