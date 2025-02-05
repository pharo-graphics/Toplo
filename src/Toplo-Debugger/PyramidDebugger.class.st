Class {
	#name : #PyramidDebugger,
	#superclass : #Object,
	#traits : 'TDebugger',
	#classTraits : 'TDebugger classTrait',
	#instVars : [
		'view',
		'stack',
		'buttons',
		'code',
		'debuggerActionModel'
	],
	#category : #'Toplo-Debugger'
}

{ #category : #'instance creation' }
PyramidDebugger class >> debugSession: aDebugSession [

	self new
		session: aDebugSession;
		open
]

{ #category : #'pyramid-serialized-bloc' }
PyramidDebugger class >> view [
	"This class has been generated using Pyramid.

	By: YannLEGOFF
	2025-02-05 16:47:51"

	<pyStash>
	^ [ {(BlElement new
   background: (BlPaintBackground new
         paint: (BlColorPaint new
               color: (Color r: 0.6510263929618768 g: 0.47214076246334313 b: 0.7145650048875856 alpha: 1.0);
               yourself);
         opacity: 1.0;
         yourself);
   addChildren: {(BlElement new
         background: (BlPaintBackground new
               paint: (BlColorPaint new
                     color: (Color r: 0.6177908113391984 g: 0.015640273704789834 b: 0.6520039100684262 alpha: 1.0);
                     yourself);
               opacity: 1.0;
               yourself);
         constraintsDo: [:constraints |  constraints horizontal matchParent.
            constraints vertical matchParent ];
         id: #stack;
         yourself) . 
      (BlElement new
         background: (BlPaintBackground new
               paint: (BlColorPaint new
                     color: (Color r: 0.024437927663734114 g: 0.49853372434017595 b: 0.4056695992179863 alpha: 1.0);
                     yourself);
               opacity: 1.0;
               yourself);
         constraintsDo: [:constraints |  constraints horizontal matchParent.
            constraints vertical exact: 24.0 ];
         id: #toolbar;
         yourself) . 
      (BlElement new
         background: (BlPaintBackground new
               paint: (BlColorPaint new
                     color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                     yourself);
               opacity: 1.0;
               yourself);
         constraintsDo: [:constraints |  constraints horizontal matchParent.
            constraints vertical matchParent ];
         id: #code;
         yourself) . 
      (BlElement new
         background: (BlPaintBackground new
               paint: (BlColorPaint new
                     color: (Color r: 0.270772238514174 g: 0.8651026392961877 b: 0.7810361681329423 alpha: 1.0);
                     yourself);
               opacity: 1.0;
               yourself);
         addChildren: {(BlElement new
               background: (BlPaintBackground new
                     paint: (BlColorPaint new
                           color: (Color r: 0.8269794721407625 g: 0.5366568914956011 b: 0.739980449657869 alpha: 1.0);
                           yourself);
                     opacity: 1.0;
                     yourself);
               constraintsDo: [:constraints |  constraints horizontal matchParent.
                  constraints vertical matchParent ];
               id: #left;
               yourself) . 
            (BlElement new
               background: (BlPaintBackground new
                     paint: (BlColorPaint new
                           color: (Color r: 0.2756598240469208 g: 0.4389051808406647 b: 0.3304007820136852 alpha: 1.0);
                           yourself);
                     opacity: 1.0;
                     yourself);
               constraintsDo: [:constraints |  constraints horizontal matchParent.
                  constraints vertical matchParent ];
               id: #right;
               yourself)};
         constraintsDo: [:constraints |  constraints horizontal matchParent.
            constraints vertical matchParent ];
         layout: BlLinearLayout horizontal;
         id: #inspector;
         yourself)};
   constraintsDo: [:constraints |  constraints horizontal matchParent.
      constraints vertical matchParent ];
   layout: BlLinearLayout vertical;
   id: #root;
   yourself)} ] value
]

{ #category : #testing }
PyramidDebugger >> defaultSelectedCodeRangeForContext: aContext [

	^ debuggerActionModel selectedCodeRangeForContext: aContext
]

{ #category : #initialization }
PyramidDebugger >> initialize [

	super initialize.
	self initializeView.

]

{ #category : #initialization }
PyramidDebugger >> initializeView [

	view := self class view first.
	stack := ToListElement new
		         constraintsDo: [ :c |
			         c vertical matchParent.
			         c horizontal matchParent ];
		         nodeBuilder: [ :node :dataItem :holder |
			         node addChild:
					         (ToLabel new text:
							          (StContextPrinter printContext: dataItem)) ];
		         addEventHandler: (BlEventHandler
				          on: ToListPrimarySelectionChangedEvent
				          do: [ :evt | self stackSelectionChanged: evt ]);
		         withRowNumbers;
		         yourself.
	code := ToAlbum new
		        withRowNumbers;
		        yourself.
	code styler: BlPharoCodeStyler new.
	(view childWithId: #stack) addChild: stack.
	(view childWithId: #code) addChild: code
]

{ #category : #'instance creation' }
PyramidDebugger >> open [

	| space |
	space := view openInNewSpace.
	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ :evt | self releaseSession ]
]

{ #category : #'as yet unclassified' }
PyramidDebugger >> releaseSession [

	debuggerActionModel clearDebugSession 
]

{ #category : #highlighting }
PyramidDebugger >> selectedCodeRangeForContext: aContext [

	^ debuggerActionModel exception
		  selectedCodeRangeForContext: aContext
		  forDebugger: self
]

{ #category : #initialization }
PyramidDebugger >> session: aSession [

	debuggerActionModel
		ifNil: [
			debuggerActionModel := StDebuggerActionModel on: aSession
			"self subscribeToActionModel" ]
		ifNotNil: [ debuggerActionModel session: aSession ].
		self updateStackFromSession: aSession.
]

{ #category : #initialization }
PyramidDebugger >> stackSelectionChanged: anEvent [

	| selectedContext interval selecter |
	anEvent selectedIndexes ifEmpty: [ ^ self ].
	selectedContext := stack dataAccessor at:
		                   anEvent selectedIndexes first.

	code styler classOrMetaClass: selectedContext receiver class.
	code text: selectedContext sourceCode.
	code editor deselecter deselect.
	interval := self selectedCodeRangeForContext: selectedContext.
	selecter := code editor selecter.
	selecter from: interval first to: interval last - 1.
	code editor navigator moveTo: interval last.
	code editor navigator apply.
	selecter select
]

{ #category : #stack }
PyramidDebugger >> updateStackFromSession: aSession [

	stack dataAccessor addAll: aSession stack
]
