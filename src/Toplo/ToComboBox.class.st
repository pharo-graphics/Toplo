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

	^ ToActionDataToElementConverter new valuable: [ :d | ToLabel text: d ] 
]

{ #category : #initialization }
ToComboBox >> defaultHeadElement [

	^ ToComboBoxHead new matchParent
]

{ #category : #initialization }
ToComboBox >> defaultHeadPlaceholder [

	^ ToLabel new 
]

{ #category : #initialization }
ToComboBox >> defaultListElement [

	^ ToListElement new
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

	^ ToActionDataToElementConverter new valuable: [ :d :h |
	  	ToLabeledNode new
		  beLabelFirst;
		  hMatchParent;
		  labelText: d;
		  yourself ]
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
ToComboBox >> defaultStartSelectedIndex [

	^ 1

	
]

{ #category : #accessing }
ToComboBox >> hasSelectedData [

	^ self selectedIndex > 0
]

{ #category : #accessing }
ToComboBox >> headContentFactory [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	^ headContentFactory
]

{ #category : #accessing }
ToComboBox >> headContentFactory: aValuable [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	headContentFactory := aValuable asToDataToElementConverter 
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
	headPlaceholder ifNil: [ headPlaceholder := self defaultHeadPlaceholder ].
	self selectedIndex ifNil: [^ self].
	self selectedIndex isZero ifTrue: [ self useHeadPlaceholder ]
]

{ #category : #displaying }
ToComboBox >> hideOrShowListPlaceholder [

	self data ifEmpty: [ ^ self showPlaceholder ].
	self hidePlaceholder
]

{ #category : #displaying }
ToComboBox >> hidePlaceholder [

	self prepareListElement 
]

{ #category : #initialization }
ToComboBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	self privateData: self newDataCollection.
	self layout: self defaultLayout.
	self headElement: self defaultHeadElement.
	self headContentFactory: self defaultHeadContentFactory.
	self listElement: self defaultListElement.
	self listFrame: self defaultListFrame.
	self prepareListElement.
	self headPlaceholder: self defaultHeadPlaceholder.
	self listPlaceholder: self defaultListPlaceholder.
	self whenSelectedIndexChangedDo: [ self selectedIndexChanged ].
	self whenHeadContentFactoryChangedDo: [ self headContentFactoryChanged  ].
	self selectIndex: 0.
	"self showListPlaceholder."
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

{ #category : #accessing }
ToComboBox >> listElementSize: aSize [

	self listElement size: aSize
]

{ #category : #accessing }
ToComboBox >> listFrame [

	^ listFrame
]

{ #category : #accessing }
ToComboBox >> listFrame: aWindow [

	listFrame := aWindow
]

{ #category : #accessing }
ToComboBox >> listPlaceholder [

	^ self listElement placeholder
]

{ #category : #accessing }
ToComboBox >> listPlaceholder: anElement [

	self listElement placeholder: anElement
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
	self listElement infinite requestFocus
]

{ #category : #displaying }
ToComboBox >> popupOrCloseEvent: anEvent [

	self listFrame isAttachedToSceneGraph
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

{ #category : #initialization }
ToComboBox >> prepareListPlaceHolder [

	self listElement next matchParent.
	self listElement next elevation: (BlRelativeElevation elevation: 0).
	self listElement placeholder elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
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

{ #category : #accessing }
ToComboBox >> selectedIndex: anInteger [

	selectedIndex := anInteger
]

{ #category : #'change hook' }
ToComboBox >> selectedIndexChanged [


]

{ #category : #displaying }
ToComboBox >> showPlaceholder [

	self listElement next matchParent.
	self listElement next elevation: (BlRelativeElevation elevation: 0).
	self listElement placeholder elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
]

{ #category : #accessing }
ToComboBox >> useHeadPlaceholder [

	self headElementContent: self headPlaceholder.
	self listElement deselectAll.
	self selectedIndex: 0
]

{ #category : #'change hook' }
ToComboBox >> whenHeadContentFactoryChangedDo: aBlock [

	"set a block to perform after that the place holder has been changed, and its action performed"

	self property: #headContentFactory whenChangedDo: aBlock
]

{ #category : #'change hook' }
ToComboBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]
