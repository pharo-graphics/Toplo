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

{ #category : #testing }
ToButterflyTheme class >> supportedVariantClasses [

	^ { ToThemeDarkVariant. ToThemeLightVariant }
]

{ #category : #accessing }
ToButterflyTheme >> expectedSkinFor: anElement [

	^ anElement skinManager defaultButterflySkin ifNil: [
		  super expectedSkinFor: anElement ]
]

{ #category : #accessing }
ToButterflyTheme >> newSkinInstanceFor: anElement [

	^ anElement newButterflySkin
]
