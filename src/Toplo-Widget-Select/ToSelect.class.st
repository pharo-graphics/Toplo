Class {
	#name : 'ToSelect',
	#superclass : 'ToPane',
	#instVars : [
		'windowManager',
		'iconHolder',
		'icon',
		'filler',
		'contentElement',
		'contentBuilder'
	],
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'accessing' }
ToSelect >> contentBuilder [

	" builds the content element. 
	aValuable take the content element as first argument 
	and the list as second argument "
	
	^ contentBuilder
]

{ #category : 'accessing' }
ToSelect >> contentBuilder: aValuable [

	" builds the content element. 
	aValuable take the content element as first argument 
	and the list as second argument "
	
	contentBuilder := aValuable
]

{ #category : 'accessing' }
ToSelect >> contentElement [

	^ contentElement 
]

{ #category : 'accessing' }
ToSelect >> currentSelectContentElement [

	^ self contentElement childWithId: #'select-content' ifNone: [  ]
]

{ #category : 'accessing' }
ToSelect >> data [

	^ self listElement data
]

{ #category : 'initialization' }
ToSelect >> defaultContentBuilder [

	^ [ :theSelectContent :aSelectedData |
	  theSelectContent addChild: ((ToLabel text: aSelectedData asString)
			   padding: (BlInsets horizontal: 3);
			   yourself) ]
]

{ #category : 'accessing' }
ToSelect >> filler [ 

	^ filler
]

{ #category : 'accessing' }
ToSelect >> icon [

	^ icon
]

{ #category : 'accessing' }
ToSelect >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self iconHolder addChild: anElement
]

{ #category : 'accessing' }
ToSelect >> iconHolder [

	^ iconHolder
]

{ #category : 'initialization' }
ToSelect >> initialize [

	super initialize.
	self fitContent.
	self layout beHorizontal.
	contentBuilder := self defaultContentBuilder.
	contentElement := self newContentElement.
	filler := self newFiller.
	iconHolder := self newIconHolder.
	self addChildren: { contentElement. filler. iconHolder }.
	windowManager := ToSelectWindowManager new element: self.
	windowManager widthHook: [ :theWindow :theElement |
		theElement measuredWidth ].
	windowManager heightHook: [ :theWindow :theElement | 400 ]
]

{ #category : 'accessing' }
ToSelect >> listElement [

	^ self windowManager listElement
]

{ #category : 'initialization' }
ToSelect >> newContentElement [

	^ ToElement new
		  vFitContent;
		hMatchParent;
		  id: #contentElement;
		  layout: BlLinearLayout horizontal;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : 'initialization' }
ToSelect >> newFiller [

	^ ToElement new
		  matchParent;
		  id: #'select-filler';
		  yourself
]

{ #category : 'initialization' }
ToSelect >> newIconHolder [

	^ ToElement new
		  fitContent;
		  id: #iconHolder;
		  layout: BlFrameLayout new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : 'skin' }
ToSelect >> newRawSkin [ 

	^ ToSelectSkin new
]

{ #category : 'accessing' }
ToSelect >> newSelectContentElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #'select-content';
		  layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : 't - infinite accessing' }
ToSelect >> nodeBuilder: aNodeFactory [

	self listElement nodeBuilder: aNodeFactory
]

{ #category : 'accessing' }
ToSelect >> selectIndexes: aCollectionOfInteger [

	| selectContent |
	aCollectionOfInteger
		ifEmpty: [ self filler matchParent ]
		ifNotEmpty: [ self filler size: 0 @ 0 ].
	self currentSelectContentElement ifNotNil: [ :child |
		child removeFromParent ].
	selectContent := self newSelectContentElement.
	self contentElement addChild: selectContent at: 1.
	aCollectionOfInteger do: [ :idx |
		self contentBuilder value: selectContent value: (self data at: idx) ]
]

{ #category : 'accessing' }
ToSelect >> windowManager [

	^ windowManager 
]

{ #category : 'accessing' }
ToSelect >> windowManager: anObject [

	windowManager := anObject
]
