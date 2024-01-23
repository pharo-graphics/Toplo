Class {
	#name : #ToDemo5,
	#superclass : #ToElement,
	#category : #'Toplo-Demo-2-ButterflyTheme'
}

{ #category : #examples }
ToDemo5 class >> example0 [

	| dem space |
	space := BlSpace new.
	space toTheme: ToButterflyTheme light.
	dem := ToDemo5 new.
	space root addChild: dem.
	space show
]

{ #category : #skin }
ToDemo5 >> newButterflySkin [ 

	^ ToDemoButSkin2 new
]

{ #category : #skin }
ToDemo5 >> newRawSkin [ 

	^ ToDemoSkin2 new
]
