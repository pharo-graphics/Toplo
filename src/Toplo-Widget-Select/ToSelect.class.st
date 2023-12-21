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
ToSelect >> contentBuilder: aValuable [

	" builds the content of the selected list nodes. 
	aValuable take the selected node collection as first argument 
	then the list node holder as second argument "
	
	contentBuilder := aValuable
]

{ #category : 'accessing' }
ToSelect >> contentElement [

	^ contentElement 
]

{ #category : 'accessing' }
ToSelect >> data [

	^ self listElement data
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
		  fitContent;
		  id: #innerElement;
		  layout: BlFlowLayout horizontal;
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

{ #category : 't - infinite accessing' }
ToSelect >> nodeBuilder: aNodeFactory [

	self listElement nodeBuilder: aNodeFactory
]

{ #category : 'accessing' }
ToSelect >> windowManager [

	^ windowManager 
]

{ #category : 'accessing' }
ToSelect >> windowManager: anObject [

	windowManager := anObject
]
