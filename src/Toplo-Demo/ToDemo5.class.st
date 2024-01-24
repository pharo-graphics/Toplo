Class {
	#name : #ToDemo5,
	#superclass : #ToElement,
	#category : #'Toplo-Demo-2-ButterflyTheme'
}

{ #category : #examples }
ToDemo5 class >> example0 [

	| dem1 dem2 space |
	space := BlSpace new.
	space root layout: BlLinearLayout vertical.
	space toTheme: ToButterflyTheme light.
	dem1 := ToDemo5 new.
	dem2 := ToDemo5 new.
	dem2 defaultButterflySkin: ToDemoButSkin2 new.
	space root addChild: dem1.
	space root addChild: dem2.
	space show
]

{ #category : #skin }
ToDemo5 >> newButterflySkin [ 

	^ ToDemoButSkin1 new
]

{ #category : #skin }
ToDemo5 >> newRawSkin [ 

	^ ToDemoSkin2 new
]
