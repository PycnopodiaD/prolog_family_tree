/*ducktree.pl
The exercise is thus to represent the information within the tree and define the following relations:

parent, son, daughter, uncle, aunt, nephew, cousin, grandfather,
grandmother, ancestor

The only facts that should exist in the program are the following:

man, woman, father, mother

Note that the predicate ancestor must be generally defined (by recursion) so it can be applied to an
arbitrary depth in the tree, for instance is Molly ancestor of Huey, etc.

You are supposed to provide a text-file with the name ducktree.txt containing executable Prolog
code. Test the following queries to see that it works:

ancestor(scotty,huey), checks that scotty is ancestor of huey
answer; (requires the user to press . to get out of the loop as there are several answers)
true .

ancestor(hortense,louie), checks that hortense is ancestor of louie-
answer; (requires the user to press . to get out of the loop as there are several answers)
true .

ancestor(X, huey), lists the ancestors of huey
answer; (if ?- ancestor(X, huey), print(X), nl, fail. is run then the spacebar is not required.)
X = della ;
X = unknown ;
X = hortense ;
X = quackmore ;
X = downey ;
X = scotty ;
X = molly ;
X = dingus ;
X = top ;
false.


ancestor(hortense,X), lists the ducks that have hortense as ancestor
answer; (if ?- ancestor(hortense,X), print(X), nl, fail. is run then the spacebar is not required.)
X = donald ;
X = della ;
X = huey ;
X = dewey ;
X = louie ;
false.


Student information;
Eric Pederson
epede@student.su.se

*/


/*Allows multiple definitions of each multifile predicate*/
:- discontiguous son/2. 
:- discontiguous child/2.
:- discontiguous parent/2.
:- discontiguous mother/2.
:- discontiguous man/1.
:- discontiguous daughter/2.
:- discontiguous sibling/2.
:- discontiguous brother/2.
:- discontiguous cousin/2.
:- discontiguous aunt/2.
:- discontiguous sister/2.
:- discontiguous partner/2.
:- discontiguous married/2.
:- discontiguous husband/2.
:- discontiguous wife/2.
:- discontiguous spouse/2.
:- discontiguous uncle/2.
:- discontiguous nephew/2.
:- discontiguous grandfather/2.
:- discontiguous grandmother/2.
:- discontiguous ancestor/2.

/* man(X) means that X is a man person */
man(scotty).
man(donald).
man(huey).
man(dewey).
man(louie).
man(dingus).
man(quagmire).
man(jake).
man(pothole).
man(quackmore).
man(goostave).
man(unknown).
man(scrooge).

/* woman(X) indicates that X is a woman person */
woman(della).
woman(molly).
woman(matilda).
woman(hortense).
woman(downey).
woman(molly).

/* mother(X,Y) indicates the mother(X) and the child(Y)*/
mother(hortense,donald).
mother(hortense,della).
mother(downey,matilda).
mother(downey,scrooge).
mother(downey,hortense).
mother(della,huey).
mother(della,dewey).
mother(della,louie).
mother(molly,scotty).
mother(molly,jake).
mother(molly,pothole).

/* father(X,Y) indicates the mother(X) and the child(Y)*/
father(scotty,matilda).
father(scotty,scrooge).
father(scotty,hortense).
father(unknown,huey).
father(unknown,dewey).
father(unknown,louie).
father(dingus,scotty).
father(dingus,jake).
father(dingus,pothole).
father(quackmore,della).
father(quackmore,donald).
father(top,dingus).
father(top,quagmire).

/* Together with a child.*/
parent(X,Y) :- mother(X,Y);father(X,Y).
	
/* Woman child of parent.*/
daughter(X,Y) :- woman(X),parent(Y,X).

/* Man child of parent.*/
son(X,Y) :- man(X),parent(Y,X).

/* Born from a parent(Y), unspecified gender.*/
child(X,Y) :- parent(Y,X).

/* Same parents as Y.*/
sibling(X,Y) :- parent(Z,X),parent(Z,Y),not(X=Y).

/* Child of one parents siblings.*/
cousin(X,Y) :- parent(Z,X),parent(W,Y),sibling(Z,W).

/* Sister to a parent.*/
aunt(X,Y) :- sibling(X,W),mother(W,Y),not(X=Y).

/* Woman with the same parents as his other sibling.*/
sister(X,Y) :- sibling(X,Y),woman(X),not(X=Y).

/* Man with the same parents as his other sibling.*/
brother(X,Y) :- sibling(X,Y),man(X),not(X=Y).

/* Married with Y with a child or children, unspecified gender.*/
partner(X,Y) :- child(Z,X),child(Z,Y),not(X=Y).

/* Married with Y, unspecified gender.*/
married(X,Y) :- husband(X,Y);wife(X,Y).

/* Married, man with Y.*/
husband(X,Y) :- man(X),partner(X,Y).

/* Married, woman with Y.*/
wife(X,Y) :- woman(X),partner(Y,X).

/* Married with Y with a child or children, unspecified gender.*/
spouse(X,Y) :- child(P,X),child(P,Y).

/* Brother to a parent or married to a parent.*/
uncle(U,N) :- parent(X,N),brother(U,X);parent(X,N),sister(S,X),spouse(U,S);married(X,N),uncle(U,X).

/* Son of a brother to Y.*/
nephew(X,Y) :- sibling(Z,Y),son(X,Z),man(X).

/* Man grandparent or fathers father.*/
grandfather(X,Y) :- man(X),parent(X,Z),parent(Z,Y),not(X=Y).

/* Woman grandparent or mothers mother.*/
grandmother(X,Y) :- parent(X,Z),woman(X),parent(Z,Y),not(X=Y).

/* Blood relationships back in time.*/
ancestor(X,Y) :- parent(X,Y);parent(Z,Y),ancestor(X,Z).


