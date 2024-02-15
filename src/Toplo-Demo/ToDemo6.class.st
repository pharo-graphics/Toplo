Class {
	#name : #ToDemo6,
	#superclass : #ToElement,
	#category : #'Toplo-Demo-3 - BeetleTheme'
}

{ #category : #examples }
ToDemo6 class >> example0 [

	| dem1 pane space |
	
	space := BlSpace new.
	space toTheme: ToBeetleTheme new.
	pane := ToPane vertical.
	dem1 := ToDemo6 new.

	pane addChild: dem1.

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
	dem2 toTheme: ToButterflyTheme new.

	pane addChild: dem1.
	pane addChild: dem2.	
	space root addChild: pane.
	space inspect.
	space show
]

{ #category : #skin }
ToDemo6 >> newButterflySkin [ 

	^ ToDemoButSkin1 new
]

{ #category : #skin }
ToDemo6 >> newRawSkin [ 

	^ ToDemoSkin2 new
]
