Class {
	#name : #ToDemo6,
	#superclass : #ToElement,
	#category : #'Toplo-Demo-3 - BeetleTheme'
}

{ #category : #examples }
ToDemo6 class >> example0 [

	| dem1 pane space dem2 |
	
	space := BlSpace new.
	space toTheme: ToBeetleTheme new.
	pane := ToPane vertical.
	dem1 := ToDemo6 new.
	dem2 := ToDemo5 new addStamp: #demo.
	"dem2 toTheme: ToButterflyTheme new."

	pane addChild: dem1.
	pane addChild: dem2.

	space root addChild: pane.
	space inspect.
	space show
]

{ #category : #examples }
ToDemo6 class >> example1 [

	| dem1 dem2 pane space |
	
	space := BlSpace new.
	space toTheme: ToBeetleTheme new.
	pane := ToPane vertical.
	dem1 := ToDemo6 new.
	
	dem2 := ToDemo5 new.
	dem2 defaultButterflySkin: ToDemoButSkin2 new.
	dem2 localTheme: ToButterflyTheme new.

	pane addChild: dem1.
	pane addChild: dem2.	
	space root addChild: pane.
	space inspect.
	space show
]

{ #category : #initialization }
ToDemo6 >> initialize [ 

	super initialize.
	self addStamp: #demo
]

{ #category : #skin }
ToDemo6 >> newButterflySkin [ 

	^ ToDemoButSkin1 new
]

{ #category : #skin }
ToDemo6 >> newRawSkin [ 

	^ ToDemoSkin2 new
]
