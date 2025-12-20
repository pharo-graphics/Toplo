Extension { #name : #TToElement }

{ #category : #'*Toplo-Widget-Float' }
TToElement >> asFloatElement [

	| holder |
	holder := ToFloatElement new.
	holder builder: [:e | e addChild: self].
	^ holder
]
