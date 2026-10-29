Class {
	#name : #PyramidDebugger,
	#superclass : #Object,
	#traits : 'TDebugger',
	#classTraits : 'TDebugger classTrait',
	#instVars : [
		'view',
		'stackWidget',
		'codeWidget',
		'debuggerActionModel',
		'allButtons',
		'synonyms'
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
	2025-02-06 11:17:55"

	<pyStash>
	^ [ | blinsets1 |
blinsets1 := BlInsets all: 8.0.
{(BlElement new
   clipChildren: false;
   addChildren: {(BlElement new
         background: (BlPaintBackground new
               paint: (BlColorPaint new
                     color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                     yourself);
               opacity: 1.0;
               yourself);
         border: (BlBorderBuilder new
               paint: (BlColorPaint new
                     color: (Color r: 0.6275659824046921 g: 0.6275659824046921 b: 0.6275659824046921 alpha: 1.0);
                     yourself);
               build);
         constraintsDo: [:constraints |  constraints horizontal fitContent.
            constraints vertical matchParent.
            constraints padding: (BlInsets all: 8.0) ];
         layout: (BlLinearLayout vertical
               cellSpacing: 8.0;
               yourself);
         id: #toolbar;
         yourself) . 
      (BlElement new
         background: (BlPaintBackground new
               paint: (BlColorPaint new
                     color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                     yourself);
               opacity: 1.0;
               yourself);
         border: (BlBorderBuilder new
               paint: (BlColorPaint new
                     color: (Color r: 0.6275659824046921 g: 0.6275659824046921 b: 0.6275659824046921 alpha: 1.0);
                     yourself);
               lineJoin: BlStrokeLineJoin bevel;
               build);
         addChildren: {(BlElement new
               background: (BlPaintBackground new
                     paint: (BlColorPaint new
                           color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                           yourself);
                     opacity: 1.0;
                     yourself);
               border: (BlBorderBuilder new
                     paint: (BlColorPaint new
                           color: (Color r: 0.6275659824046921 g: 0.6275659824046921 b: 0.6275659824046921 alpha: 1.0);
                           yourself);
                     lineJoin: BlStrokeLineJoin bevel;
                     build);
               constraintsDo: [:constraints |  constraints horizontal matchParent.
                  constraints vertical matchParent.
                  constraints padding: blinsets1 ];
               id: #stack;
               yourself) . 
            (BlElement new
               background: (BlPaintBackground new
                     paint: (BlColorPaint new
                           color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                           yourself);
                     opacity: 1.0;
                     yourself);
               border: (BlBorderBuilder new
                     paint: (BlColorPaint new
                           color: (Color r: 0.6275659824046921 g: 0.6275659824046921 b: 0.6275659824046921 alpha: 1.0);
                           yourself);
                     lineJoin: BlStrokeLineJoin bevel;
                     build);
               constraintsDo: [:constraints |  constraints horizontal matchParent.
                  constraints vertical matchParent.
                  constraints padding: blinsets1 ];
               id: #code;
               yourself) . 
            (BlElement new
               background: (BlPaintBackground new
                     paint: (BlColorPaint new
                           color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                           yourself);
                     opacity: 1.0;
                     yourself);
               border: (BlBorderBuilder new
                     paint: (BlColorPaint new
                           color: (Color r: 0.6275659824046921 g: 0.6275659824046921 b: 0.6275659824046921 alpha: 1.0);
                           yourself);
                     lineJoin: BlStrokeLineJoin bevel;
                     build);
               addChildren: {(BlElement new
                     background: (BlPaintBackground new
                           paint: (BlColorPaint new
                                 color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                                 yourself);
                           opacity: 1.0;
                           yourself);
                     border: (BlBorderBuilder new
                           paint: (BlColorPaint new
                                 color: (Color r: 0.6275659824046921 g: 0.6275659824046921 b: 0.6275659824046921 alpha: 1.0);
                                 yourself);
                           lineJoin: BlStrokeLineJoin bevel;
                           build);
                     constraintsDo: [:constraints |  constraints horizontal matchParent.
                        constraints vertical matchParent.
                        constraints padding: blinsets1 ];
                     id: #left;
                     yourself) . 
                  (BlElement new
                     background: (BlPaintBackground new
                           paint: (BlColorPaint new
                                 color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
                                 yourself);
                           opacity: 1.0;
                           yourself);
                     border: (BlBorderBuilder new
                           paint: (BlColorPaint new
                                 color: (Color r: 0.6275659824046921 g: 0.6275659824046921 b: 0.6275659824046921 alpha: 1.0);
                                 yourself);
                           lineJoin: BlStrokeLineJoin bevel;
                           build);
                     constraintsDo: [:constraints |  constraints horizontal matchParent.
                        constraints vertical matchParent.
                        constraints padding: blinsets1 ];
                     id: #right;
                     yourself)};
               constraintsDo: [:constraints |  constraints horizontal matchParent.
                  constraints vertical matchParent.
                  constraints padding: blinsets1 ];
               layout: BlLinearLayout horizontal;
               id: #inspector;
               yourself)};
         constraintsDo: [:constraints |  constraints horizontal matchParent.
            constraints vertical matchParent.
            constraints padding: blinsets1 ];
         layout: BlLinearLayout vertical;
         id: #mainPanel;
         yourself)};
   constraintsDo: [:constraints |  constraints horizontal matchParent.
      constraints vertical matchParent ];
   layout: BlLinearLayout horizontal;
   id: #root;
   yourself)} ] value
]

{ #category : #accessing }
PyramidDebugger >> allButtons [

	^ allButtons
]

{ #category : #accessing }
PyramidDebugger >> codeWidget [

	^ codeWidget
]

{ #category : #accessing }
PyramidDebugger >> debuggerActionModel [

	^ debuggerActionModel
]

{ #category : #accessing }
PyramidDebugger >> debuggerActionModel: anObject [

	debuggerActionModel := anObject
]

{ #category : #testing }
PyramidDebugger >> defaultSelectedCodeRangeForContext: aContext [

	^ self debuggerActionModel selectedCodeRangeForContext: aContext
]

{ #category : #initialization }
PyramidDebugger >> initialize [

	super initialize.
	self initializeSynonyms.
	self initializeWidgets.
	self initializeButtons.
	self initializeView
]

{ #category : #initialization }
PyramidDebugger >> initializeButtons [

	allButtons := OrderedCollection new.
	
	allButtons := StDebuggerToolbarCommandTreeBuilder new executionControlCommandClasses collect: [ :commandClass |
		(self
			 newButtonWithLabel: commandClass defaultName
			 withIcon: (Smalltalk ui icons iconNamed: (self synonyms at: commandClass defaultIconName))
			 withCallback: [ commandClass new execute ]).
		 ]
]

{ #category : #initialization }
PyramidDebugger >> initializeSynonyms [
	
	synonyms := Dictionary new.
	synonyms
		at: #debuggerCopyStack put: #smallCopy;
		at: #debuggerDefineEntity put: #changeAdd;
		at: #debuggerPeelToFirst put: #down;
		at: #debuggerProceed put: #glamorousGo;
		at: #debuggerRestart put: #glamorousRestart;
		at: #debuggerReturn put: #refresh;
		at: #debuggerStepInto put: #glamorousInto;
		at: #debuggerStepOver put: #glamorousOver;
		at: #debuggerStepThrough put: #glamorousThrough;
		at: #debuggerRunToSelection put: #glamorousRightSide;
		at: #debuggerWhereIs put: #glamorousSearch
]

{ #category : #initialization }
PyramidDebugger >> initializeView [

	view := self class view first.
	((view childWithId: #mainPanel) childWithId: #stack) addChild:
		self stackWidget.
	((view childWithId: #mainPanel) childWithId: #code) addChild:
		self codeWidget.

	self allButtons do: [ :button |
		(view childWithId: #toolbar) addChild: button ]
]

{ #category : #initialization }
PyramidDebugger >> initializeWidgets [

	stackWidget := ToListElement new
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

	codeWidget := ToAlbum new
		        styler: BlPharoCodeStyler new;
		        withRowNumbers;
		        yourself
]

{ #category : #initialization }
PyramidDebugger >> newButtonWithLabel: aString withIcon: aForm withCallback: aBlock [

	^ ToButton new
		  labelText: aString;
		  iconImage: aForm;
		  whenClickedDo: aBlock;
		  beVertical;
		constraintsDo: [ :c | c horizontal matchParent ];
		  yourself
]

{ #category : #'instance creation' }
PyramidDebugger >> open [

	| space |
	space := view openInNewSpace.
	space addEventHandlerOn: BlSpaceShownEvent do: [ :evt | evt target center ].
	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ :evt | self releaseSession ]
]

{ #category : #'as yet unclassified' }
PyramidDebugger >> releaseSession [

	self debuggerActionModel clearDebugSession
]

{ #category : #highlighting }
PyramidDebugger >> selectedCodeRangeForContext: aContext [

	^ self debuggerActionModel exception
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
	selectedContext := stackWidget dataAccessor at:
		                   anEvent selectedIndexes first.

	self codeWidget styler classOrMetaClass:
		selectedContext receiver class.
	self codeWidget text: selectedContext sourceCode.
	self codeWidget editor deselecter deselect.
	interval := self selectedCodeRangeForContext: selectedContext.
	selecter := self codeWidget editor selecter.
	selecter from: interval first - 1 to: interval last.
	self codeWidget editor navigator moveTo: interval last.
	self codeWidget editor navigator apply.
	selecter select
]

{ #category : #accessing }
PyramidDebugger >> stackWidget [

	^ stackWidget
]

{ #category : #initialization }
PyramidDebugger >> synonyms [

	^ synonyms
]

{ #category : #stack }
PyramidDebugger >> updateStackFromSession: aSession [

	self stackWidget dataAccessor addAll: aSession stack
]

{ #category : #accessing }
PyramidDebugger >> view [

	^ view
]
