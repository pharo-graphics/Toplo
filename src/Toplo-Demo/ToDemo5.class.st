Class {
	#name : #ToDemo5,
	#superclass : #ToElement,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #examples }
ToDemo5 class >> example0 [

	| dem1 dem2 pane |
	pane := ToPane vertical.
	pane toTheme: ToButterflyTheme new.
	dem1 := ToDemo5 new.
	dem2 := ToDemo5 new.
	dem2 defaultButterflySkin: ToDemoButSkin2 new.
	dem2 addEventHandler: (BlEventHandler
			 on: ToElementLookEvent
			 do: [ :evt | evt target = dem2 ifTrue: [ evt traceCr ] ]).
	pane addChild: dem1.
	pane addChild: dem2.
	
	pane openInSpace
]

{ #category : #skin }
ToDemo5 >> newButterflySkin [ 

	^ ToDemoButSkin1 new
]

{ #category : #skin }
ToDemo5 >> newRawSkin [ 

	^ ToDemoSkin2 new
]
