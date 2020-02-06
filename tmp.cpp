// Static collisions, i.e. overlap
		for (auto &A : vecAs)
		{
			for (auto &B : vecAs)
			{
				if (A.id != B.id)
				{
					if (DoCirclesOverlap(A.x, A.y, A.r, B.x, B.y, B.r))
					{
						// Collision has occured
						vecCollidingPairs.push_back({ &A, &B });

						// Distance between A centers
						float distance = sqrtf((A.x - B.x)*(A.x - B.x) + (A.y - B.y)*(A.y - B.y));

						// Calculate displacement required
						float overlap = 0.5f * (distance - A.r - B.r);

						// Displace Current A away from collision
						A.x -= overlap * (A.x - B.x) / distance;
						A.y -= overlap * (A.y - B.y) / distance;

						// Displace B A away from collision
						B.x += overlap * (A.x - B.x) / distance;
						B.y += overlap * (A.y - B.y) / distance;
					}
				}
			}
		}

		// Now work out dynamic collisions
		for (auto c : vecCollidingPairs)
		{
			sA *A = c.first;
			sA *B = c.second;

			// Distance between As
			float distance = sqrtf((A.x - B.x)*(A.x - B.x) + (A.y - B.y)*(A.y - B.y));

			// Normal
			float nx = (B.x - A.x) / distance;
			float ny = (B.y - A.y) / distance;

			// Tangent
			float tx = -ny;
			float ty = nx;

			// Dot Product Tangent
			float dpTan1 = A.vx * tx + A.vy * ty;
			float dpTan2 = B.vx * tx + B.vy * ty;

			// Dot Product Normal
			float dpNorm1 = A.vx * nx + A.vy * ny;
			float dpNorm2 = B.vx * nx + B.vy * ny;

			// Conservation of momentum in 1D
			float m1 = (dpNorm1 * (A.m - B.m) + 2.0f * B.m * dpNorm2) / (A.m + B.m);
			float m2 = (dpNorm2 * (B.m - A.m) + 2.0f * A.m * dpNorm1) / (A.m + B.m);

			// Update A velocities
			A.vx = tx * dpTan1 + nx * m1;
			A.vy = ty * dpTan1 + ny * m1;
			B.vx = tx * dpTan2 + nx * m2;
			B.vy = ty * dpTan2 + ny * m2;

			// Wikipedia Version - Maths is smarter but same
			//float kx = (A.vx - B.vx);
			//float ky = (A.vy - B.vy);
			//float p = 2.0 * (nx * kx + ny * ky) / (A.m + B.m);
			//A.vx = A.vx - p * B.m * nx;
			//A.vy = A.vy - p * B.m * ny;
			//B.vx = B.vx + p * A.m * nx;
			//B.vy = B.vy + p * A.m * ny;
		}