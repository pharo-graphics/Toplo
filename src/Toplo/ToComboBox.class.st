Class {
	#name : #ToComboBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#data',
		'#selectedIndex => ObservableSlot',
		'#listElement',
		'#listPlaceHolder',
		'#listFrame',
		'#headFactory',
		'#headElement',
		'#headPlaceHolder'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #events }
ToComboBox >> clickOnDataEvent: aClickOnDataEvent [

	self selectIndex: aClickOnDataEvent index.
	self closeEvent: aClickOnDataEvent event
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

{ #category : #initialization }
ToComboBox >> defaultButtonPlaceHolder [

	^ ToLabel text: 'Button place holder'
]

{ #category : #'t - initialization dresser' }
ToComboBox >> defaultDresser [

	^ ToComboBoxDresser new
]

{ #category : #initialization }
ToComboBox >> defaultHeadFactory [

	^ [ :d |
	  | pair head |
	  pair := ToPairedElement new
		          hMatchParent;
		          first: (ToLabel text: d);
		          second: (ToButton new icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)));
		          yourself.
	  head := ToComboBoxHead new.
	  head addChild: pair.
	  head ]
]

{ #category : #initialization }
ToComboBox >> defaultListElement [

	^ ToListElement new
		  matchParent;
		  nodeFactory: self defaultNodeFactory;
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
	win root size: self defaultListElementSize.
	win root addChild: self listElement.
	^  win
]

{ #category : #initialization }
ToComboBox >> defaultListPlaceHolder [

	^ ToLabel text: 'List place holder'
]

{ #category : #initialization }
ToComboBox >> defaultNodeFactory [

	^ [ :d |
	  ToLabeledNode new
		  beLabelFirst;
		  hMatchParent;
		  labelText: d;
		  yourself ]
]

{ #category : #initialization }
ToComboBox >> defaultStartSelectedIndex [

	^ 1

	
]

{ #category : #accessing }
ToComboBox >> headData: aData [

	self headElement: (self headFactory cull: aData cull: self headElement)
]

{ #category : #accessing }
ToComboBox >> headElement [

	^ headElement
]

{ #category : #accessing }
ToComboBox >> headElement: anElement [

	headElement = anElement ifTrue: [ ^ self ].
	headElement ifNotNil: [
		headElement removeFromParent ].
	headElement := anElement.
	self addChild: headElement
]

{ #category : #accessing }
ToComboBox >> headFactory [
	" a Valuable can take 2 args, a selected data value and the previous button"

	^ headFactory
]

{ #category : #accessing }
ToComboBox >> headFactory: aValuable [
	" a Valuable can take 2 args, a selected data value and the previous button"

	headFactory := aValuable
]

{ #category : #accessing }
ToComboBox >> headPlaceHolder [

	^ headPlaceHolder
]

{ #category : #accessing }
ToComboBox >> headPlaceHolder: anElement [

	headPlaceHolder := anElement
]

{ #category : #'change hook' }
ToComboBox >> headPlaceHolderChanged [
]

{ #category : #initialization }
ToComboBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	self privateData: self newDataCollection.
	self layout: self defaultLayout.
	self headFactory: self defaultHeadFactory.
	self listElement: self defaultListElement.
	self listFrame: self defaultListFrame.
	self fitContent.
	self whenSelectedIndexChangedDo: [ self selectedIndexChanged ].
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

	self listFrameSize: aSize
]

{ #category : #accessing }
ToComboBox >> listFrame [

	^ listFrame
]

{ #category : #initialization }
ToComboBox >> listFrame: aWindow [

	listFrame := aWindow
]

{ #category : #initialization }
ToComboBox >> listFrameSize: aSize [

	self listFrame root size: aSize
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
ToComboBox >> listPlaceHolder [

	^ listPlaceHolder
]

{ #category : #accessing }
ToComboBox >> listPlaceHolder: anElement [

	listPlaceHolder := anElement
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

{ #category : #events }
ToComboBox >> selectIndex: anIndex [

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

{ #category : #'change hook' }
ToComboBox >> whenHeadPlaceHolderChangedDo: aBlock [

	"set a block to perform after that the place holder has been changed, and its action performed"

	self property: #headPlaceHolder whenChangedDo: aBlock
]

{ #category : #'change hook' }
ToComboBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]
