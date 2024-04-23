Class {
	#name : #ToInfiniteRowNumberDecoration,
	#superclass : #BlRowNumberDecoration,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToInfiniteRowNumberDecoration >> aeBackgroundBoundsOn: aeCanvas in: anInfiniteElement [

	| bnds hgap vgap |
	bnds := super aeBackgroundBoundsOn: aeCanvas in: anInfiniteElement.
	hgap := (anInfiniteElement listElement padding left) - 1.
	vgap := (anInfiniteElement listElement padding top) - 1.
	^ ((bnds origin x - hgap) @ (bnds origin y - vgap)) extent: bnds width @ (bnds height + (vgap * 2))
]

{ #category : #geometry }
ToInfiniteRowNumberDecoration >> numberLeftGap [

	" the gap between the row number background left and the row number"
	^ 0
]
