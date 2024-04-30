Class {
	#name : #ToDemo7,
	#superclass : #ToElement,
	#instVars : [
		'dem6',
		'dem62'
	],
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #examples }
ToDemo7 class >> example1 [

	| dem7 space  |
	space := BlSpace new.
	space 	toTheme: ToButterflyTheme new.

	dem7 := ToDemo7 new.
	dem7 defaultButterflySkin: ToDemo7ButterflySkin1 new.
	space root addChild: dem7.
	space show
]

{ #category : #examples }
ToDemo7 class >> example2 [

	| dem7 space  |
	space := BlSpace new.
	space 	toTheme: ToButterflyTheme new.
	dem7 := ToDemo7 new.
	dem7 defaultButterflySkin: ToDemo7ButterflySkin2 new.
	space root addChild: dem7.
	space show
]

{ #category : #accessing }
ToDemo7 >> dem6 [

	^ dem6
]

{ #category : #accessing }
ToDemo7 >> dem62 [

	^ dem62
]

{ #category : #initialization }
ToDemo7 >> initialize [

	super initialize.
	dem6 := ToDemo6 new.
	dem62 := BlElement new.
	self layout: BlLinearLayout horizontal.
	self addChild: dem6.
	self addChild: dem62.
]
