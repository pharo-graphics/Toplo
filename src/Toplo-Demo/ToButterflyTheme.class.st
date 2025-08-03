Class {
	#name : #ToButterflyTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #testing }
ToButterflyTheme class >> canBeDefault [

	^ true
]

{ #category : #accessing }
ToButterflyTheme class >> label [

	^'Butterfly'
]

{ #category : #accessing }
ToButterflyTheme >> defaultSkinFor: anElement [

	^ anElement skinManager defaultButterflySkin ifNil: [
		  super defaultSkinFor: anElement ]
]

{ #category : #accessing }
ToButterflyTheme >> newSkinFor: anElement [

	^ anElement newButterflySkin
]
